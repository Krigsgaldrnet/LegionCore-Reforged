-- ==========================================================================
-- Skyreach Beam — Veil Akraz ambient event (Spires of Arak)
-- Permanent invisible NPC that fires the beam every 5 minutes
-- Run against world_legion database
-- ==========================================================================

-- Clean up previous entries
DELETE FROM `creature` WHERE `id` = 900100;
DELETE FROM `creature_template` WHERE `entry` IN (900100, 900101, 900102);
DELETE FROM `creature_template_wdb` WHERE `Entry` IN (900100, 900101, 900102);

-- ========================================
-- creature_template_wdb (client-side data)
-- ========================================
-- Type 10 = Not Specified (invisible helper)
-- Displayid 11686 = invisible stalker model
INSERT INTO `creature_template_wdb` (`Entry`, `Name1`, `Name2`, `Name3`, `Name4`, `NameAlt1`, `NameAlt2`, `NameAlt3`, `NameAlt4`, `Title`, `TitleAlt`, `CursorName`, `TypeFlags`, `TypeFlags2`, `Type`, `Family`, `Classification`, `KillCredit1`, `KillCredit2`, `VignetteID`, `Displayid1`, `Displayid2`, `Displayid3`, `Displayid4`, `HpMulti`, `PowerMulti`, `Leader`, `QuestItem1`, `QuestItem2`, `QuestItem3`, `QuestItem4`, `QuestItem5`, `QuestItem6`, `QuestItem7`, `QuestItem8`, `QuestItem9`, `QuestItem10`, `MovementInfoID`, `RequiredExpansion`, `FlagQuest`, `VerifiedBuild`) VALUES
(900100, 'Skyreach Beam Controller', '', '', '', '', '', '', '', '', '', '', 0, 0, 10, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1),
-- NPC 900101: Beam source — visible model (displayId 46710 = Sun Construct Energizer / Interior Focus)
(900101, 'Skyreach Beam Source', '', '', '', '', '', '', '', '', '', '', 0, 0, 10, 0, 0, 0, 0, 0, 46710, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1),
-- NPC 900102: Beam target — invisible stalker (channel target point)
(900102, 'Skyreach Beam Target', '', '', '', '', '', '', '', '', '', '', 0, 0, 10, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1);

-- ========================================
-- creature_template (server-side data)
-- ========================================
-- faction 35 = Friendly to all
-- unit_flags: NOT_SELECTABLE (0x02000000) | NON_ATTACKABLE (0x00000002) = 33554434
-- flags_extra: 2 = CREATURE_FLAG_EXTRA_NO_XP_AT_KILL
INSERT INTO `creature_template` (`entry`, `gossip_menu_id`, `minlevel`, `maxlevel`, `HealthScalingExpansion`, `SandboxScalingID`, `exp`, `faction`, `npcflag`, `npcflag2`, `speed_walk`, `speed_run`, `speed_fly`, `scale`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `Mana_mod_extra`, `Armor_mod`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ControllerID`, `WorldEffects`, `PassiveSpells`, `StateWorldEffectID`, `SpellStateVisualID`, `SpellStateAnimID`, `SpellStateAnimKitID`, `IgnoreLos`, `AffixState`, `MaxVisible`, `ScriptName`) VALUES
(900100, 0, 100, 100, 0, 0, 5, 35, 0, 0, 1.0, 1.14286, 1.14286, 1.0, 0, 0, 0, 0, 1.0, 2000, 0, 1, 33554434, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 0, 2, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 'npc_skyreach_beam_controller'),
-- NPC 900101: Beam source — visible, non-selectable, flies, MaxVisible (channels beam)
(900101, 0, 100, 100, 0, 0, 5, 35, 0, 0, 1.0, 1.14286, 1.14286, 1.0, 0, 0, 0, 0, 1.0, 2000, 0, 1, 33554434, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 0, 2, 0, '', '', 0, 0, 0, 0, 0, 0, 1, ''),
-- NPC 900102: Beam target — invisible stalker, non-selectable, flies, MaxVisible (channel endpoint)
(900102, 0, 100, 100, 0, 0, 5, 35, 0, 0, 1.0, 1.14286, 1.14286, 1.0, 0, 0, 0, 0, 1.0, 2000, 0, 1, 33554434, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 0, 2, 0, '', '', 0, 0, 0, 0, 0, 0, 1, '');

-- ========================================
-- creature_template_addon: bytes1 = 50331648 (0x03000000 = AnimTier::Hover — fly/hover on spawn)
-- ========================================
DELETE FROM `creature_template_addon` WHERE `entry` IN (900101, 900102);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(900101, 0, 0, 50331648, 1, 0, ''),
(900102, 0, 0, 50331648, 1, 0, '');

-- ========================================
-- Ground Fire (large) — clone of 248100 with size 2.0
-- ========================================
DELETE FROM `gameobject_template` WHERE `entry` = 248101;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `VerifiedBuild`) VALUES
(248101, 5, 32556, 'Ground Fire Large', 2.0, 21287);

-- ========================================
-- Permanent spawn in Spires of Arak (map 1116, zone 6722)
-- Position at Veil Akraz ground level
-- ========================================
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags3`) VALUES
(900100, 900100, 1116, 6722, 0, 1, 1, '', 0, 0, 370, 2060, 2, 0, 120, 0, 0, 1, 0, 0, 0, 0, 0);
