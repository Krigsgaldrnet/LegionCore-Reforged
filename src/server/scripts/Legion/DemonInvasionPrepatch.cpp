/*
 * Demon Invasion Prepatch - Legion Pre-expansion Event
 * Implementation: DemonInvasionMgr, OutdoorPvP handlers, GM commands
 */

#include "DemonInvasionPrepatch.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "OutdoorPvPMgr.h"
#include "GameEventMgr.h"
#include "Chat.h"
#include "Player.h"
#include "World.h"
#include "Log.h"
#include "Creature.h"
#include <sstream>
#include <cstdarg>

// ============================================================================
// Zone data tables
// ============================================================================

static const DemonInvasionZoneInfo s_zoneInfos[DI_ZONE_MAX] =
{
    { 16,  1, "Azshara"          }, // 0 - Kalimdor
    { 1,   0, "Dun Morogh"       }, // 1 - EK
    { 267, 0, "Hillsbrad"        }, // 2 - EK
    { 10,  1, "Northern Barrens" }, // 3 - Kalimdor
    { 440, 1, "Tanaris"          }, // 4 - Kalimdor
    { 40,  0, "Westfall"         }, // 5 - EK
};

static const uint32 s_killThresholds[DI_STAGE_MAX] =
{
    0,    // INACTIVE - unused
    50,   // DEFEND - kill demons around hub
    3,    // COMMANDER - kill commander + 2 lieutenants
    100,  // REPEL - clear zone
    1,    // BOSS - kill the final boss
};

static const char* s_stageNames[DI_STAGE_MAX] =
{
    "Inactive", "Defend", "Commander", "Repel", "Boss"
};

// ============================================================================
// DemonInvasionMgr — singleton implementation
// ============================================================================

DemonInvasionMgr::DemonInvasionMgr()
    : m_rotationTimer(DI_ROTATION_INTERVAL)
    , m_initialized(false)
{
    for (uint8 i = 0; i < DI_ZONE_MAX; ++i)
    {
        m_zoneStates[i].stage = DI_STAGE_INACTIVE;
        m_zoneStates[i].stageProgress = 0;
    }
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT; ++i)
        m_activeZones[i] = DI_ZONE_MAX; // none
}

DemonInvasionMgr* DemonInvasionMgr::instance()
{
    static DemonInvasionMgr inst;
    return &inst;
}

void DemonInvasionMgr::Initialize()
{
    if (m_initialized)
        return;

    m_initialized = true;
    m_rotationTimer = 10 * 1000; // First rotation 10s after init

    TC_LOG_INFO("server.loading", "[DemonInvasion] Prepatch invasion system initialized.");
}

void DemonInvasionMgr::Update(uint32 diff)
{
    if (!m_initialized)
        return;

    if (m_rotationTimer <= diff)
    {
        RotateInvasions();
        m_rotationTimer = DI_ROTATION_INTERVAL;
    }
    else
        m_rotationTimer -= diff;
}

// ============================================================================
// Static helpers
// ============================================================================

const DemonInvasionZoneInfo& DemonInvasionMgr::GetZoneInfo(uint8 index)
{
    static const DemonInvasionZoneInfo s_invalid = { 0, 0, "Unknown" };
    if (index >= DI_ZONE_MAX)
        return s_invalid;
    return s_zoneInfos[index];
}

uint16 DemonInvasionMgr::GetGameEventId(uint8 zoneIndex, uint8 stage)
{
    // stage 1..4 -> offset 0..3
    if (stage < 1 || stage > 4 || zoneIndex >= DI_ZONE_MAX)
        return 0;
    return DI_GAME_EVENT_BASE + (zoneIndex * 4) + (stage - 1);
}

uint32 DemonInvasionMgr::GetKillThreshold(uint8 stage)
{
    if (stage >= DI_STAGE_MAX)
        return 0;
    return s_killThresholds[stage];
}

bool DemonInvasionMgr::IsInvasionCreature(uint32 entry)
{
    return entry >= 900001 && entry <= 900099;
}

// ============================================================================
// Core invasion mechanics
// ============================================================================

void DemonInvasionMgr::StartInvasion(uint8 zoneIndex)
{
    if (zoneIndex >= DI_ZONE_MAX)
        return;

    auto& state = m_zoneStates[zoneIndex];
    state.stage = DI_STAGE_DEFEND;
    state.stageProgress = 0;

    uint16 eventId = GetGameEventId(zoneIndex, DI_STAGE_DEFEND);
    if (eventId)
        sGameEventMgr->StartEvent(eventId, true);

    TC_LOG_INFO("scripts", "[DemonInvasion] Invasion STARTED in %s (zone %u), event %u",
        s_zoneInfos[zoneIndex].name, s_zoneInfos[zoneIndex].zoneId, eventId);

    BroadcastToZone(zoneIndex,
        "|cFFFF0000[Demon Invasion]|r The Burning Legion is invading %s! Defend the area!",
        s_zoneInfos[zoneIndex].name);
}

void DemonInvasionMgr::StopInvasion(uint8 zoneIndex)
{
    if (zoneIndex >= DI_ZONE_MAX)
        return;

    auto& state = m_zoneStates[zoneIndex];

    // Stop current stage event
    if (state.stage > DI_STAGE_INACTIVE && state.stage < DI_STAGE_MAX)
    {
        uint16 eventId = GetGameEventId(zoneIndex, state.stage);
        if (eventId)
            sGameEventMgr->StopEvent(eventId, true);
    }

    state.stage = DI_STAGE_INACTIVE;
    state.stageProgress = 0;

    TC_LOG_INFO("scripts", "[DemonInvasion] Invasion STOPPED in %s",
        s_zoneInfos[zoneIndex].name);

    BroadcastToZone(zoneIndex,
        "|cFF00FF00[Demon Invasion]|r The invasion in %s has been repelled!",
        s_zoneInfos[zoneIndex].name);
}

void DemonInvasionMgr::AdvanceStage(uint8 zoneIndex)
{
    if (zoneIndex >= DI_ZONE_MAX)
        return;

    auto& state = m_zoneStates[zoneIndex];

    // If boss stage just completed -> invasion over
    if (state.stage == DI_STAGE_BOSS)
    {
        BroadcastToZone(zoneIndex,
            "|cFF00FF00[Demon Invasion]|r The demon lord in %s has been vanquished!",
            s_zoneInfos[zoneIndex].name);
        StopInvasion(zoneIndex);
        return;
    }

    if (state.stage == DI_STAGE_INACTIVE)
        return;

    // Stop current stage event
    uint16 oldEventId = GetGameEventId(zoneIndex, state.stage);
    if (oldEventId)
        sGameEventMgr->StopEvent(oldEventId, true);

    // Advance to next stage
    state.stage = static_cast<DemonInvasionStage>(static_cast<uint8>(state.stage) + 1);
    state.stageProgress = 0;

    // Start new stage event
    uint16 newEventId = GetGameEventId(zoneIndex, state.stage);
    if (newEventId)
        sGameEventMgr->StartEvent(newEventId, true);

    TC_LOG_INFO("scripts", "[DemonInvasion] %s advanced to stage %u (%s), event %u",
        s_zoneInfos[zoneIndex].name, state.stage, s_stageNames[state.stage], newEventId);

    BroadcastToZone(zoneIndex,
        "|cFFFFFF00[Demon Invasion]|r %s - Stage %u: %s!",
        s_zoneInfos[zoneIndex].name, state.stage, s_stageNames[state.stage]);
}

void DemonInvasionMgr::RotateInvasions()
{
    // Stop current active invasions
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT; ++i)
    {
        if (m_activeZones[i] < DI_ZONE_MAX)
            StopInvasion(m_activeZones[i]);
        m_activeZones[i] = DI_ZONE_MAX;
    }

    // Build candidate list and shuffle
    std::vector<uint8> candidates;
    candidates.reserve(DI_ZONE_MAX);
    for (uint8 i = 0; i < DI_ZONE_MAX; ++i)
        candidates.push_back(i);

    // Fisher-Yates shuffle
    for (int32 i = static_cast<int32>(candidates.size()) - 1; i > 0; --i)
    {
        uint32 j = urand(0, static_cast<uint32>(i));
        std::swap(candidates[i], candidates[j]);
    }

    // Pick first DI_ACTIVE_ZONE_COUNT zones
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT && i < static_cast<uint8>(candidates.size()); ++i)
    {
        m_activeZones[i] = candidates[i];
        StartInvasion(m_activeZones[i]);
    }

    TC_LOG_INFO("scripts", "[DemonInvasion] Rotation complete: %s and %s active. Next rotation in %u hours.",
        m_activeZones[0] < DI_ZONE_MAX ? s_zoneInfos[m_activeZones[0]].name : "None",
        m_activeZones[1] < DI_ZONE_MAX ? s_zoneInfos[m_activeZones[1]].name : "None",
        DI_ROTATION_INTERVAL / 3600000);
}

void DemonInvasionMgr::OnCreatureKill(uint32 zoneId, uint32 creatureEntry, Player* /*killer*/)
{
    uint8 zi = GetZoneIndexByZoneId(zoneId);
    if (zi >= DI_ZONE_MAX)
        return;

    auto& state = m_zoneStates[zi];
    if (state.stage == DI_STAGE_INACTIVE)
        return;

    if (!IsInvasionCreature(creatureEntry))
        return;

    ++state.stageProgress;

    uint32 threshold = GetKillThreshold(state.stage);
    if (threshold > 0 && state.stageProgress >= threshold)
    {
        TC_LOG_INFO("scripts", "[DemonInvasion] %s stage %u complete (%u/%u kills)",
            s_zoneInfos[zi].name, state.stage, state.stageProgress, threshold);
        AdvanceStage(zi);
    }
}

// ============================================================================
// GM Commands
// ============================================================================

bool DemonInvasionMgr::ForceStart(uint32 zoneId)
{
    uint8 zi = GetZoneIndexByZoneId(zoneId);
    if (zi >= DI_ZONE_MAX)
        return false;

    if (!m_initialized)
        Initialize();

    // If already active, stop first
    if (m_zoneStates[zi].stage != DI_STAGE_INACTIVE)
        StopInvasion(zi);

    // Find an empty slot or replace first slot
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT; ++i)
    {
        if (m_activeZones[i] >= DI_ZONE_MAX)
        {
            m_activeZones[i] = zi;
            StartInvasion(zi);
            return true;
        }
    }

    // All slots full - replace slot 0
    StopInvasion(m_activeZones[0]);
    m_activeZones[0] = zi;
    StartInvasion(zi);
    return true;
}

void DemonInvasionMgr::ForceStop()
{
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT; ++i)
    {
        if (m_activeZones[i] < DI_ZONE_MAX)
            StopInvasion(m_activeZones[i]);
        m_activeZones[i] = DI_ZONE_MAX;
    }
}

void DemonInvasionMgr::ForceStage(uint8 zoneIndex, uint8 stage)
{
    if (zoneIndex >= DI_ZONE_MAX || stage >= DI_STAGE_MAX)
        return;

    auto& state = m_zoneStates[zoneIndex];

    // Stop current event if active
    if (state.stage > DI_STAGE_INACTIVE && state.stage < DI_STAGE_MAX)
    {
        uint16 oldEvent = GetGameEventId(zoneIndex, state.stage);
        if (oldEvent)
            sGameEventMgr->StopEvent(oldEvent, true);
    }

    if (stage == DI_STAGE_INACTIVE)
    {
        state.stage = DI_STAGE_INACTIVE;
        state.stageProgress = 0;
        return;
    }

    state.stage = static_cast<DemonInvasionStage>(stage);
    state.stageProgress = 0;

    uint16 newEvent = GetGameEventId(zoneIndex, state.stage);
    if (newEvent)
        sGameEventMgr->StartEvent(newEvent, true);

    TC_LOG_INFO("scripts", "[DemonInvasion] GM forced %s to stage %u (%s), event %u",
        s_zoneInfos[zoneIndex].name, stage, s_stageNames[stage], newEvent);
}

void DemonInvasionMgr::ForceRotate()
{
    RotateInvasions();
    m_rotationTimer = DI_ROTATION_INTERVAL;
}

// ============================================================================
// Queries
// ============================================================================

bool DemonInvasionMgr::IsZoneActive(uint8 zoneIndex) const
{
    if (zoneIndex >= DI_ZONE_MAX)
        return false;
    return m_zoneStates[zoneIndex].stage != DI_STAGE_INACTIVE;
}

DemonInvasionStage DemonInvasionMgr::GetZoneStage(uint8 zoneIndex) const
{
    if (zoneIndex >= DI_ZONE_MAX)
        return DI_STAGE_INACTIVE;
    return m_zoneStates[zoneIndex].stage;
}

uint8 DemonInvasionMgr::GetZoneIndexByZoneId(uint32 zoneId) const
{
    for (uint8 i = 0; i < DI_ZONE_MAX; ++i)
        if (s_zoneInfos[i].zoneId == zoneId)
            return i;
    return DI_ZONE_MAX;
}

std::string DemonInvasionMgr::GetStatusString() const
{
    std::ostringstream ss;
    ss << "|cFFFFD700=== Demon Invasion Status ===|r\n";
    ss << "Rotation timer: " << (m_rotationTimer / 1000) << "s ("
       << (m_rotationTimer / 60000) << " min)\n";
    ss << "Active zones: ";
    for (uint8 i = 0; i < DI_ACTIVE_ZONE_COUNT; ++i)
    {
        if (m_activeZones[i] < DI_ZONE_MAX)
            ss << s_zoneInfos[m_activeZones[i]].name;
        else
            ss << "None";
        if (i < DI_ACTIVE_ZONE_COUNT - 1)
            ss << ", ";
    }
    ss << "\n";
    for (uint8 i = 0; i < DI_ZONE_MAX; ++i)
    {
        ss << "  " << s_zoneInfos[i].name
           << " (zone " << s_zoneInfos[i].zoneId << "): "
           << s_stageNames[m_zoneStates[i].stage];
        if (m_zoneStates[i].stage != DI_STAGE_INACTIVE)
        {
            ss << " [" << m_zoneStates[i].stageProgress
               << "/" << s_killThresholds[m_zoneStates[i].stage] << " kills]";
        }
        ss << "\n";
    }
    return ss.str();
}

void DemonInvasionMgr::BroadcastToZone(uint8 zoneIndex, const char* format, ...)
{
    char buffer[512];
    va_list args;
    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    va_end(args);

    // Broadcast to all players (zone-specific filtering deferred to Phase 4)
    sWorld->SendGlobalText(buffer, nullptr);
}

// ============================================================================
// OutdoorPvP: Eastern Kingdoms (Dun Morogh, Hillsbrad, Westfall)
// ============================================================================

bool OutdoorPvPDemonInvasionEK::SetupOutdoorPvP()
{
    RegisterZone(1);    // Dun Morogh
    RegisterZone(267);  // Hillsbrad
    RegisterZone(40);   // Westfall
    return true;
}

bool OutdoorPvPDemonInvasionEK::Update(uint32 diff)
{
    // EK instance drives the DemonInvasionMgr timer
    if (!sDemonInvasionMgr->IsInitialized())
        sDemonInvasionMgr->Initialize();

    sDemonInvasionMgr->Update(diff);
    return true;
}

void OutdoorPvPDemonInvasionEK::HandleKillImpl(Player* killer, Unit* killed)
{
    if (!killed || !killed->ToCreature())
        return;

    sDemonInvasionMgr->OnCreatureKill(
        killed->GetCurrentZoneID(),
        killed->GetEntry(),
        killer
    );
}

// ============================================================================
// OutdoorPvP: Kalimdor (Azshara, Northern Barrens, Tanaris)
// ============================================================================

bool OutdoorPvPDemonInvasionKal::SetupOutdoorPvP()
{
    RegisterZone(16);   // Azshara
    RegisterZone(10);   // Northern Barrens
    RegisterZone(440);  // Tanaris
    return true;
}

bool OutdoorPvPDemonInvasionKal::Update(uint32 diff)
{
    // Kalimdor doesn't drive the timer - EK does
    return true;
}

void OutdoorPvPDemonInvasionKal::HandleKillImpl(Player* killer, Unit* killed)
{
    if (!killed || !killed->ToCreature())
        return;

    sDemonInvasionMgr->OnCreatureKill(
        killed->GetCurrentZoneID(),
        killed->GetEntry(),
        killer
    );
}

// ============================================================================
// GM Command Script: .invasion start/stop/stage/status/rotate
// ============================================================================

class demon_invasion_commandscript : public CommandScript
{
public:
    demon_invasion_commandscript() : CommandScript("demon_invasion_commandscript") {}

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> invasionCommandTable =
        {
            { "start",   SEC_GAMEMASTER, false, &HandleInvasionStartCommand,  "" },
            { "stop",    SEC_GAMEMASTER, false, &HandleInvasionStopCommand,   "" },
            { "stage",   SEC_GAMEMASTER, false, &HandleInvasionStageCommand,  "" },
            { "status",  SEC_GAMEMASTER, false, &HandleInvasionStatusCommand, "" },
            { "rotate",  SEC_GAMEMASTER, false, &HandleInvasionRotateCommand, "" },
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "invasion", SEC_GAMEMASTER, false, NULL, "", invasionCommandTable },
        };

        return commandTable;
    }

    // .invasion start [zoneId]
    static bool HandleInvasionStartCommand(ChatHandler* handler, char const* args)
    {
        if (!sDemonInvasionMgr->IsInitialized())
            sDemonInvasionMgr->Initialize();

        uint32 zoneId = 0;
        if (args && args[0])
            zoneId = static_cast<uint32>(atoi(args));
        else
        {
            // Random zone
            zoneId = DemonInvasionMgr::GetZoneInfo(urand(0, DI_ZONE_MAX - 1)).zoneId;
        }

        if (sDemonInvasionMgr->ForceStart(zoneId))
            handler->PSendSysMessage("[DemonInvasion] Invasion started in zone %u (%s).",
                zoneId, DemonInvasionMgr::GetZoneInfo(
                    sDemonInvasionMgr->GetZoneIndexByZoneId(zoneId)).name);
        else
            handler->PSendSysMessage("[DemonInvasion] Invalid zone ID %u. Valid: 16 1 267 10 440 40", zoneId);
        return true;
    }

    // .invasion stop
    static bool HandleInvasionStopCommand(ChatHandler* handler, char const* /*args*/)
    {
        sDemonInvasionMgr->ForceStop();
        handler->PSendSysMessage("[DemonInvasion] All invasions stopped.");
        return true;
    }

    // .invasion stage <zoneIndex 0-5> <stage 0-4>
    static bool HandleInvasionStageCommand(ChatHandler* handler, char const* args)
    {
        if (!args || !args[0])
        {
            handler->PSendSysMessage("Usage: .invasion stage <zoneIndex 0-5> <stage 0-4>");
            handler->PSendSysMessage("Zones: 0=Azshara 1=DunMorogh 2=Hillsbrad 3=Barrens 4=Tanaris 5=Westfall");
            handler->PSendSysMessage("Stages: 0=Inactive 1=Defend 2=Commander 3=Repel 4=Boss");
            return true;
        }

        uint32 zoneIndex = 0, stage = 0;
        if (sscanf(args, "%u %u", &zoneIndex, &stage) != 2)
        {
            handler->PSendSysMessage("Usage: .invasion stage <zoneIndex 0-5> <stage 0-4>");
            return true;
        }

        if (zoneIndex >= DI_ZONE_MAX || stage >= DI_STAGE_MAX)
        {
            handler->PSendSysMessage("[DemonInvasion] Invalid zone index (0-5) or stage (0-4).");
            return true;
        }

        sDemonInvasionMgr->ForceStage(static_cast<uint8>(zoneIndex), static_cast<uint8>(stage));
        handler->PSendSysMessage("[DemonInvasion] %s forced to stage %u (%s).",
            DemonInvasionMgr::GetZoneInfo(static_cast<uint8>(zoneIndex)).name,
            stage, s_stageNames[stage]);
        return true;
    }

    // .invasion status
    static bool HandleInvasionStatusCommand(ChatHandler* handler, char const* /*args*/)
    {
        if (!sDemonInvasionMgr->IsInitialized())
        {
            handler->PSendSysMessage("[DemonInvasion] System not initialized. Use .invasion start or .invasion rotate first.");
            return true;
        }

        handler->SendSysMessage(sDemonInvasionMgr->GetStatusString().c_str());
        return true;
    }

    // .invasion rotate
    static bool HandleInvasionRotateCommand(ChatHandler* handler, char const* /*args*/)
    {
        if (!sDemonInvasionMgr->IsInitialized())
            sDemonInvasionMgr->Initialize();

        sDemonInvasionMgr->ForceRotate();
        handler->PSendSysMessage("[DemonInvasion] Rotation forced. Check .invasion status for active zones.");
        return true;
    }
};

// ============================================================================
// OutdoorPvP Script Registration
// ============================================================================

class OutdoorPvP_DemonInvasion_EK : public OutdoorPvPScript
{
public:
    OutdoorPvP_DemonInvasion_EK() : OutdoorPvPScript("outdoorpvp_demon_invasion_ek") {}

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPDemonInvasionEK();
    }
};

class OutdoorPvP_DemonInvasion_Kal : public OutdoorPvPScript
{
public:
    OutdoorPvP_DemonInvasion_Kal() : OutdoorPvPScript("outdoorpvp_demon_invasion_kal") {}

    OutdoorPvP* GetOutdoorPvP() const override
    {
        return new OutdoorPvPDemonInvasionKal();
    }
};

// ============================================================================
// Script registration entry point
// ============================================================================

// Forward declaration from DemonInvasionPrepatch_creatures.cpp
void AddSC_demon_invasion_creatures();

void AddSC_demon_invasion_prepatch()
{
    new OutdoorPvP_DemonInvasion_EK();
    new OutdoorPvP_DemonInvasion_Kal();
    new demon_invasion_commandscript();
    AddSC_demon_invasion_creatures();
}
