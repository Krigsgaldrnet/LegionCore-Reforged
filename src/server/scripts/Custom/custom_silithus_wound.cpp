/*
 * Silithus : la Plaie - voyage dans le temps (contenu custom)
 *
 * Zidormi, 128607, se tient dans Silithus depuis toujours mais n'avait ni menu ni script. Le
 * terrain de Legion est la lui aussi : phase_definitions echange la zone 1377 vers la carte 1817,
 * et depuis 2026_09_08_03 il remplit VisibleMapID, sans quoi le sol restait celui de 2006.
 *
 * L'aura 255152 dit "Silithus avant que le monde soit blesse" : la porter, c'est se tenir dans la
 * zone d'avant, ne pas la porter c'est le present, ou l'epee est plantee.
 *
 * Elle est permanente et sauvegardee, et rien ne la retire tout seul : un joueur garde sa version
 * en quittant la zone, en changeant de carte et en se reconnectant.
 *
 * Custom.SilithusWound.Default dit seulement si le voyage est ouvert. A 1 Zidormi propose la
 * seule ligne qui manque - le passe a qui est au present, le retour a qui est dans le passe. A 0
 * elle n'a rien a dire et la zone reste au present, l'epee plantee comme le patch 7.3 l'a laissee.
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Creature.h"
#include "GossipDef.h"
#include "World.h"
#include "PhaseMgr.h"
#include "ConditionMgr.h"
#include "Map.h"

enum SilithusWound
{
    NPC_ZIDORMI_SILITHUS   = 128607,
    ZONE_SILITHUS          = 1377,
    SPELL_TIME_TRAVELLING  = 255152,   // la porter, c'est etre avant la Plaie ; sans elle, l'epee
    GOSSIP_TEXT_ZIDORMI    = 14065,    // le texte de Zidormi, celui que sert deja celle de Norfendre

    ACTION_TO_THE_PAST     = GOSSIP_ACTION_INFO_DEF + 1,   // pose l'aura : voyager avant la Plaie
    ACTION_TO_THE_PRESENT  = GOSSIP_ACTION_INFO_DEF + 2    // la retire : revenir, l'epee reapparait
};

#define GOSSIP_SHOW_PAST    "Montre-moi Silithus avant la Plaie."
#define GOSSIP_SHOW_PRESENT "Ramene-moi au present."

class npc_zidormi_silithus : public CreatureScript
{
public:
    npc_zidormi_silithus() : CreatureScript("npc_zidormi_silithus") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        // Voyage ferme : elle n'ouvre rien.
        if (!sWorld->getBoolConfig(CONFIG_SILITHUS_WOUND_DEFAULT))
            return false;

        // Une seule ligne, celle qui mene ailleurs que la ou on se tient.
        if (player->HasAura(SPELL_TIME_TRAVELLING))
            player->ADD_GOSSIP_ITEM(GossipOptionNpc::None, GOSSIP_SHOW_PRESENT, GOSSIP_SENDER_MAIN, ACTION_TO_THE_PRESENT);
        else
            player->ADD_GOSSIP_ITEM(GossipOptionNpc::None, GOSSIP_SHOW_PAST, GOSSIP_SENDER_MAIN, ACTION_TO_THE_PAST);

        player->SEND_GOSSIP_MENU(GOSSIP_TEXT_ZIDORMI, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();

        if (action == ACTION_TO_THE_PAST)
            player->AddAura(SPELL_TIME_TRAVELLING, player);
        else if (action == ACTION_TO_THE_PRESENT)
            player->RemoveAurasDueToSpell(SPELL_TIME_TRAVELLING);
        else
        {
            player->PlayerTalkClass->SendCloseGossip();
            return true;
        }

        // Le coeur ne previent le gestionnaire de phases pour aucun changement d'aura : rien dans
        // les chemins d'aura ne mentionne CONDITION_AURA. Sans ce rappel, la phase n'est recalculee
        // qu'au prochain changement de zone - l'epee restait donc en place au clic, puis basculait
        // en sortant de Silithus et rebasculait en y revenant.
        PhaseUpdateData phaseUpdateData;
        phaseUpdateData.AddConditionType(CONDITION_AURA);
        player->GetPhaseMgr().NotifyConditionChanged(phaseUpdateData);

        player->PlayerTalkClass->SendCloseGossip();

        // Le recalcul ci-dessus suffit aux objets et aux creatures, pas au sol : un VisibleMapID
        // n'est lu par le client qu'au chargement de la carte, si bien que le terrain restait celui
        // d'avant jusqu'a ce qu'on sorte de la zone et qu'on y revienne. Une teleportation sur
        // place lui fait recharger, ce qui est aussi ce que fait le jeu - la bascule de Zidormi
        // passe par un bref ecran de chargement.
        //
        // TELE_TO_ZONE_MAP est indispensable : sans lui SafeTeleport voit la meme carte et prend le
        // chemin proche, qui deplace le joueur sans rien recharger - donc sans ecran de chargement
        // et sans nouveau sol. Ce drapeau force le chemin lointain sur place, et il epargne au
        // passage les auras portant AURA_INTERRUPT_FLAG_CHANGE_MAP, ce qui compte ici puisque le
        // marqueur temporel doit survivre au voyage qu'il declenche.
        player->TeleportTo(player->GetMapId(), player->GetPositionX(), player->GetPositionY(),
                           player->GetPositionZ(), player->GetOrientation(), TELE_TO_ZONE_MAP);
        return true;
    }
};

class player_silithus_wound_gate : public PlayerScript
{
public:
    player_silithus_wound_gate() : PlayerScript("player_silithus_wound_gate") {}

    void OnUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
    {
        if (!player)
            return;

        if (newZone != ZONE_SILITHUS)
            return;

        // Le voyage ferme ne doit laisser personne echoue dans le passe : un marqueur pris avant
        // que l'option ne soit coupee est rendu a l'entree dans la zone. Le present redevient alors
        // le seul etat possible, l'epee plantee.
        if (!sWorld->getBoolConfig(CONFIG_SILITHUS_WOUND_DEFAULT) && player->HasAura(SPELL_TIME_TRAVELLING))
        {
            player->RemoveAurasDueToSpell(SPELL_TIME_TRAVELLING);

            PhaseUpdateData phaseUpdateData;
            phaseUpdateData.AddConditionType(CONDITION_AURA);
            player->GetPhaseMgr().NotifyConditionChanged(phaseUpdateData);
        }
    }

    void OnLogin(Player* player) override
    {
        if (!player)
            return;

        // La grille de l'effet de l'epee est forcee au chargement. Sans cela l'objet n'existe pas
        // tant que personne n'est passe a cote : il n'entre dans le monde qu'avec sa grille, et
        // AddMaxVisible ignore ce qui n'y est pas. Une fois cree il se marque actif et sa grille ne
        // se decharge plus - il fallait seulement la charger une premiere fois.
        if (player->GetMapId() == 1)
            if (Map* map = player->GetMap())
                map->LoadGrid(-7128.0f, 930.0f);
    }


    // Rien ici ne recharge plus le terrain a l'entree dans la zone. Ce rechargement existait parce
    // que sortir de Silithus faisait tomber la bascule de terrain, phase_definitions etant indexe
    // par zone ; depuis 2026_09_08_11 la definition est donnee a toutes les zones de Kalimdor, la
    // bascule ne tombe donc plus et franchir une frontiere ne change rien. Seule Zidormi decide, et
    // c'est elle seule qui provoque un ecran de chargement.
};

void AddSC_custom_silithus_wound()
{
    new npc_zidormi_silithus();
    new player_silithus_wound_gate();
}
