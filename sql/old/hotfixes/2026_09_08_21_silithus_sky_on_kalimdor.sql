-- The light has to be on the map the client actually loads.
--
-- This is the thing nobody had measured, and it is the root cause of every failure so far. The
-- client loads map 1 - Client.log, 14:33:51: "Client : Load Map Begin : 1". The terrain swap
-- exchanges the ground, not the light table. Lights declared on ContinentID 1817 are never read,
-- wherever they sit and whatever they point at.
--
-- The measurements behind that:
--   - no light of ContinentID 1 covers the Wound at all. The nearest, 249, is 466 yards away with
--     a reach of 34.
--   - Kalimdor's global light is 191, at the origin with falloff 0/0, whose LightParams 192 has
--     LightSkyboxID 0. So the default over Silithus is, by construction, no sky.
--   - ZoneLight.db2 has no entry for map 1817.
--   - every sky that has ever worked on this realm had its carrier light on the map the player
--     physically stands on: 530 for Quel'Thalas, 0 for Stormwind. No exception.
--
-- Update 19 already puts the sky inside the parameter sets the zone uses, and those are shared
-- with Kalimdor: light 250 is the twin of 9150, 278 the twin of 9151, 2766 the twin of 9152, at
-- the same coordinates. So the sky reaches Zidormi through 278 on its own. What it does not reach
-- is the Wound itself, because Blizzard lit that corner with 249 and its 34-yard bubble.
--
-- Hence one light, on Kalimdor, over the Wound. Its extent is the zone's, not a point I chose:
-- the creatures carrying the Wound phase span x -8084 to -6172 and y -321 to 1938. Centred on
-- -7100 / 800 with 1200 in and 1700 out, it covers the whole of it and fades before the borders.
-- It points at 254, the parameter update 19 gives the sky to, in the clear slot and the storm slot
-- both, and keeps Blizzard's 207 and 3 elsewhere - so it casts the light 254 was authored with,
-- and only adds a sky.
--
-- 9330 sits above the highest id the client's Light.db2 holds, 9249. A created light works on the
-- physical map: 9302 was created the same way on map 0 for the Stormwind sky and was seen in game.
--
-- What this costs: a light on map 1 knows nothing about phases, so both timelines get this sky
-- over the Wound - the old zone as well as the Plaie. Phase-aware lighting does not exist in this
-- client; the only lever is position, and both timelines occupy the same ground.
--
-- TableHash 1556783290 Light.

DELETE FROM `light` WHERE `ID` = 9330;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9330, -7100, 800, 0, 1200, 1700, 1, 254, 207, 254, 207, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` = 9000464;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000464, 1556783290, 9330, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 61;
