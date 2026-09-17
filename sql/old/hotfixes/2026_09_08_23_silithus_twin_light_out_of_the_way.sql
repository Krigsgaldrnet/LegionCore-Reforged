-- The twin light must not light anything by itself.
--
-- Update 22 put 9331 at the same place and with the same reach as 9330, meaning to keep it in
-- reserve as an override target. There is no such thing as a light in reserve: a Light record
-- applies wherever its sphere reaches, whether or not anything "chooses" it. So two lights covered
-- the Wound and the client blended them - one with a sky and one without, one with Glow 0.75 and
-- one with 0. That is the fog that came back.
--
-- It moves to ContinentID 1817, the Wound's own terrain map. Today's measurement is what makes that
-- the right place: the client loads map 1 and never reads the lights of a swapped map, so nothing
-- there is ever selected by position. The record still exists and can still be named in
-- SMSG_OVERRIDE_LIGHT, which looks it up by id.
--
-- TableHash 1556783290 Light.
DELETE FROM `light` WHERE `ID` = 9331;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9331, -7100, 800, 0, 1200, 1700, 1817, 253, 207, 408, 207, 3, 0, 0, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 63;
