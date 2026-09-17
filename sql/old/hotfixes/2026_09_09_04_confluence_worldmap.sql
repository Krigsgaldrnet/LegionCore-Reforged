-- World map for map 2678.
--
-- The two eras store the art differently. Dragonflight ships one 512x512 texture per ADT tile under
-- world/maptextures/, and the client assembles them; a 7.3.5 client wants a single picture cut into
-- twelve 256x256 tiles under Interface\WorldMap\<AreaName>\<AreaName>1..12.blp. build_worldmap.py
-- does that conversion, which is why AreaName is '2678': it IS the folder and file prefix.
--
-- The four Loc bounds are the world coordinates of the art's edges, and they are read off the tile
-- grid rather than guessed: a tile at index i spans (32 - i - 1) to (32 - i) times 533.33333, so
-- the eight columns 36-43 give Y from -2133.333 down to -6400, and the eight rows 32-39 give X from
-- 0 down to -4266.667. LocLeft/LocRight are Y, LocTop/LocBottom are X.
--
-- The map is square and the 7.3.5 canvas is not, so the picture is stretched rather than
-- letterboxed - margins would put the edges elsewhere than these bounds say, and the whole point of
-- the bounds is to place the player's dot correctly.
--
-- TableHash 1404082561 WorldMapArea.

DELETE FROM `world_map_area` WHERE `ID` = 2678;
INSERT INTO `world_map_area` (`ID`, `AreaName`, `LocLeft`, `LocRight`, `LocTop`, `LocBottom`,
                              `Flags`, `MapID`, `AreaID`, `DisplayMapID`, `DefaultDungeonFloor`,
                              `ParentWorldMapID`, `LevelRangeMin`, `LevelRangeMax`, `BountySetID`,
                              `BountyDisplayLocation`, `VisibilityPlayerConditionID`,
                              `VerifiedBuild`) VALUES
(2678, '2678', -2133.333, -6400, 0, -4266.667,
 0, 2678, 15010, 65535, 0,
 0, 0, 0, 0,
 0, 0,
 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000486;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000486, 1404082561, 2678, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 71;
