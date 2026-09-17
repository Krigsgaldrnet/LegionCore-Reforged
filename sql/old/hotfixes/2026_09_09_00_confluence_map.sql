-- Map 2678 does not exist in a 7.3.5 client, so it is created.
--
-- Map.db2 stops at 1903 here, and the whole map has to be declared before the client will load a
-- single tile of it. Only SQL can do this: a hotfix row can add a DB2 record the client has never
-- seen, whereas the core can only edit one it already has.
--
-- The Directory is "2678" and that is not a placeholder - it is the real one. Every path Blizzard
-- ships uses it: world/maps/2678/2678.wdt, world/minimaps/2678/, world/maptextures/2678/. So the
-- files land exactly where the client will look for them, with no renaming anywhere.
--
-- The numbers are Argus's, read out of Map.db2 rather than invented, because Argus is the closest
-- thing this client has to what 2678 is: a continent-type outdoor map with no parent, reached only
-- by teleport. Flags1 0xa01e5d, Flags2 0x30, wind 12, MapType 1, InstanceType 0. The expansion is
-- left at 6, the highest this client knows, so nothing refuses it for a missing expansion.
--
-- AreaTableID stays 0 until the zones are declared; the map loads without it, the zone simply has
-- no name yet.
--
-- TableHash 3179597154 Map.

DELETE FROM `map` WHERE `ID` = 2678;
INSERT INTO `map` (`ID`, `Directory`, `MapName`, `MapDescription0`, `MapDescription1`,
                   `PvpShortDescription`, `PvpLongDescription`, `Flags1`, `Flags2`,
                   `MinimapIconScale`, `CorpsePosX`, `CorpsePosY`, `AreaTableID`, `LoadingScreenID`,
                   `CorpseMapID`, `TimeOfDayOverride`, `ParentMapID`, `CosmeticParentMapID`,
                   `WindSettingsID`, `InstanceType`, `MapType`, `ExpansionID`, `MaxPlayers`,
                   `TimeOffset`, `VerifiedBuild`) VALUES
(2678, '2678', 'La Confluence temporelle', '', '', '', '', 10493021, 48,
 1, 0, 0, 0, 432,
 -1, 65535, -1, -1,
 12, 0, 1, 6, 0,
 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000480;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000480, 3179597154, 2678, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 67;
