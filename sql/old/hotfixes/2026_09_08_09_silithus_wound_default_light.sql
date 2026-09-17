-- The default light of a map is the one with the lowest ID, not the one with a zero falloff.
--
-- 9320 was written with falloff 0/0, the shape every map default has, but it was also the highest
-- ID on map 1817 - after 9150, 9151 and 9152 - and the client never picked it. The sky showed only
-- inside light 9151, whose 196/306 reach happens to sit on Zidormi, and vanished a few steps away.
--
-- Checked against every map that has one: the default is the lowest ID of its map, without a
-- single exception. Map 0 uses 1, map 1 uses 191, map 13 uses 346. So the record is recreated as
-- 9000, below the three that already exist.
DELETE FROM `light` WHERE `ID` IN (9320, 9000);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9000, 0, 0, 0, 0, 0, 1817, 3706, 11, 3706, 11, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000443, 9000447);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000443, 1556783290, 9320, 0, 1),
(9000447, 1556783290, 9000, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 49;
