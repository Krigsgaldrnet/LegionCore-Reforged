-- The sky moves onto the crater itself.
--
-- The first position was the centroid of the 773 creatures carrying the Wound phase, but those are
-- spread over the whole zone, so the light landed on the middle of Silithus and the sky was up
-- from the moment you set foot in it.
--
-- The crater is found in the terrain instead. Reading the 10240 chunks of map 1817 - the client
-- calls it silithusphase01 - the ground runs from -754 to 391, median -7, and the two hundred
-- lowest chunks sit together around -7035 / 2861. The single deepest is -6967 / 2700 at -754.
-- That hole is the wound, and the sword stands in it.
--
-- Area 9310 "Silithus: The Wound" was no help: it covers 4667 of those chunks, nearly the whole
-- map, so it names the zone rather than the crater.
--
-- 600 in and 1100 out: solid over the hole, coming up as you walk down into it.
DELETE FROM `light` WHERE `ID` = 9001;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9001, -6967, 2700, 0, 600, 1100, 1817, 3706, 11, 3706, 11, 3, 0, 0, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 51;
