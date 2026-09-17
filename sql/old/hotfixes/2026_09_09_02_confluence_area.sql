-- Area 15010, the one the map's own terrain asks for.
--
-- Every MCNK of map 2678 carries area id 15010 and AreaTable.db2 stops at 9531 here, so the client
-- looks up a record that does not exist each time it steps into a chunk. The zone would have no
-- name, no ambience and no music, and a null lookup on that path is not something to leave standing.
--
-- The id is not chosen: it is the one written in the terrain, kept so the ADTs need no editing.
--
-- AreaBit stays 0 on purpose. It is the index of the zone's bit in the exploration mask, and any
-- value already in use would have the player discover someone else's zone. 0 means "not explorable",
-- which is what an area with no exploration reward should be.
--
-- ParentAreaID 0 makes it a zone rather than a subzone. Flags are left clear: nothing here needs
-- flying, sanctuary or arena rules yet.
--
-- TableHash 1918102339 AreaTable, 3179597154 Map.

DELETE FROM `area_table` WHERE `ID` = 15010;
INSERT INTO `area_table` (`ID`, `ZoneName`, `AreaName`, `Flags1`, `Flags2`, `AmbientMultiplier`,
                          `ContinentID`, `ParentAreaID`, `AreaBit`, `AmbienceID`, `ZoneMusic`,
                          `IntroSound`, `LiquidTypeID1`, `LiquidTypeID2`, `LiquidTypeID3`,
                          `LiquidTypeID4`, `UwZoneMusic`, `UwAmbience`, `PvpCombatWorldStateID`,
                          `SoundProviderPref`, `SoundProviderPrefUnderwater`, `ExplorationLevel`,
                          `FactionGroupMask`, `MountFlags`, `WildBattlePetLevelMin`,
                          `WildBattlePetLevelMax`, `WindSettingsID`, `UwIntroSound`,
                          `VerifiedBuild`) VALUES
(15010, 'TemporalConfluence', 'La Confluence temporelle', 0, 0, 1,
 2678, 0, 0, 0, 0,
 0, 0, 0, 0,
 0, 0, 0, 0,
 0, 0, 110,
 0, 1, 0,
 0, 12, 0,
 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000482;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000482, 1918102339, 15010, 0, 0);

UPDATE `map` SET `AreaTableID` = 15010 WHERE `ID` = 2678;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 69;
