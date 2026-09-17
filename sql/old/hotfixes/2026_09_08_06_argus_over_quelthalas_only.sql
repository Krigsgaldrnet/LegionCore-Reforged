-- ==========================================================================================
-- Argus over Quel'Thalas, and nowhere else on map 530.
--
-- MapCelestialBody attaches a celestial body to a whole map, so records 8 and 15 were deleted on
-- 2026-08-30: Quel'Thalas shares map 530 with Outland, and Argus has no business hanging over
-- Hellfire or Nagrand. But the attachment carries a PlayerConditionID, and a player condition can
-- test the area - of the 630 conditions that use AreaID, 653 references point at a root zone and
-- only 422 at a subzone, so the client matches a zone even when the player stands in one of its
-- subzones.
--
-- So record 8 comes back, pointed at a new condition instead of Blizzard's 54101:
--
--   54103 = 54101, minus the aura requirement, plus AreaID 3430 Eversong Woods, 3433 Ghostlands,
--           3487 Silvermoon City, AreaLogic 10.
--
-- AreaLogic is two bits per extra slot - 2 for two areas, 10 for three, 42 for four - read off the
-- records that use it. The aura is dropped for the same reason the C++ generator drops it from
-- 54101: the planet should show without the player carrying the P.R.O.F.I.L. filter buff.
--
-- Three fields are stored as their two's complement: the core reads ChrSpecializationIndex,
-- ChrSpecializationRole and PowerType as int8 while the column is tinyint unsigned, so the -1 that
-- means "no requirement" is written 255.
--
-- Record 15 stays deleted. It is the post-Antorus glow, body 20, whose condition 53936 was already
-- pushed out of reach.
--
-- TableHash 3108775943 is PlayerCondition and 2523168314 MapCelestialBody, both read from the
-- header of the client's own db2, the field at offset 20.
-- ==========================================================================================

DELETE FROM `player_condition` WHERE `ID` = 54103;
INSERT INTO `player_condition` (`RaceMask`, `FailureDescription`, `ID`, `Flags`, `MinLevel`, `MaxLevel`, `ClassMask`, `Gender`, `NativeGender`, `SkillLogic`, `LanguageID`, `MinLanguage`, `MaxLanguage`, `MaxFactionID`, `MaxReputation`, `ReputationLogic`, `CurrentPvpFaction`, `MinPVPRank`, `MaxPVPRank`, `PvpMedal`, `PrevQuestLogic`, `CurrQuestLogic`, `CurrentCompletedQuestLogic`, `SpellLogic`, `ItemLogic`, `ItemFlags`, `AuraSpellLogic`, `WorldStateExpressionID`, `WeatherID`, `PartyStatus`, `LifetimeMaxPVPRank`, `AchievementLogic`, `LfgLogic`, `AreaLogic`, `CurrencyLogic`, `QuestKillID`, `QuestKillLogic`, `MinExpansionLevel`, `MaxExpansionLevel`, `MinExpansionTier`, `MaxExpansionTier`, `MinGuildLevel`, `MaxGuildLevel`, `PhaseUseFlags`, `PhaseID`, `PhaseGroupID`, `MinAvgItemLevel`, `MaxAvgItemLevel`, `MinAvgEquippedItemLevel`, `MaxAvgEquippedItemLevel`, `ChrSpecializationIndex`, `ChrSpecializationRole`, `PowerType`, `PowerTypeComp`, `PowerTypeValue`, `ModifierTreeID`, `WeaponSubclassMask`, `SkillID1`, `SkillID2`, `SkillID3`, `SkillID4`, `MinSkill1`, `MinSkill2`, `MinSkill3`, `MinSkill4`, `MaxSkill1`, `MaxSkill2`, `MaxSkill3`, `MaxSkill4`, `MinFactionID1`, `MinFactionID2`, `MinFactionID3`, `MinReputation1`, `MinReputation2`, `MinReputation3`, `PrevQuestID1`, `PrevQuestID2`, `PrevQuestID3`, `PrevQuestID4`, `CurrQuestID1`, `CurrQuestID2`, `CurrQuestID3`, `CurrQuestID4`, `CurrentCompletedQuestID1`, `CurrentCompletedQuestID2`, `CurrentCompletedQuestID3`, `CurrentCompletedQuestID4`, `SpellID1`, `SpellID2`, `SpellID3`, `SpellID4`, `ItemID1`, `ItemID2`, `ItemID3`, `ItemID4`, `ItemCount1`, `ItemCount2`, `ItemCount3`, `ItemCount4`, `Explored1`, `Explored2`, `Time1`, `Time2`, `AuraSpellID1`, `AuraSpellID2`, `AuraSpellID3`, `AuraSpellID4`, `AuraStacks1`, `AuraStacks2`, `AuraStacks3`, `AuraStacks4`, `Achievement1`, `Achievement2`, `Achievement3`, `Achievement4`, `LfgStatus1`, `LfgStatus2`, `LfgStatus3`, `LfgStatus4`, `LfgCompare1`, `LfgCompare2`, `LfgCompare3`, `LfgCompare4`, `LfgValue1`, `LfgValue2`, `LfgValue3`, `LfgValue4`, `AreaID1`, `AreaID2`, `AreaID3`, `AreaID4`, `CurrencyID1`, `CurrencyID2`, `CurrencyID3`, `CurrencyID4`, `CurrencyCount1`, `CurrencyCount2`, `CurrencyCount3`, `CurrencyCount4`, `QuestKillMonster1`, `QuestKillMonster2`, `QuestKillMonster3`, `QuestKillMonster4`, `QuestKillMonster5`, `QuestKillMonster6`, `MovementFlags1`, `MovementFlags2`, `VerifiedBuild`) VALUES
(0, 0, 54103, 1, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3430, 3433, 3487, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26972);

DELETE FROM `map_celestial_body` WHERE `ID` = 8;
INSERT INTO `map_celestial_body` (`ID`, `CelestialBodyID`, `PlayerConditionID`, `MapID`, `VerifiedBuild`) VALUES
(8, 9, 54103, 530, 26972);

-- Record 8 stops being a deletion and becomes an update; 15 keeps its own.
DELETE FROM `hotfix_data` WHERE `Id` IN (9000219, 9000440);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000219, 2523168314,     8, 0, 0),
(9000440, 3108775943, 54103, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 46;
