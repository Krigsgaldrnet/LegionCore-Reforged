-- The sky is confined to one parameter set, and the old timeline gets a twin without it.
--
-- Update 19 put the sky into the six parameter sets Silithus uses, which was the way to reach it
-- through Kalimdor's own lights. It reaches too much: 253 and 408 light Zidormi and her
-- surroundings, 1000 and 1002 the west, 425 six lights across several zones - and none of them
-- knows anything about timelines. Those five go back exactly as Blizzard wrote them, values read
-- from LightParams.db2.
--
-- Only 254 keeps the sky. On Kalimdor it is reached by two lights: 250, in the far north of
-- Silithus at -6158 / 3473, and 9330, the one added over the Wound. So the sky is the Wound's and
-- almost nothing else's.
--
-- 9331 is that same light without a sky - same place, same reach, pointing at 253 and 408, the
-- parameters that light Zidormi, so it casts Silithus's own daylight. Nothing selects it on its
-- own: it exists to be handed to a single player through SMSG_OVERRIDE_LIGHT, whose AreaLightID
-- field lets one light be swapped for another for one client. That is how a player standing before
-- the Wound gets the sky taken away while everyone else keeps it - the client has no phase-aware
-- lighting of its own, and this is the only lever there is.
--
-- TableHash 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_params` WHERE `ID` IN (425, 253, 408, 1000, 1002);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0, 0, 0, 0, 0,  425, 26972),
(0,    0.5, 1, 0.75, 1, 0, 0, 0, 0, 0, 0, 0,  253, 26972),
(0.4,  0.5, 1, 0.75, 1, 0, 0, 0, 0, 0, 0, 0,  408, 26972),
(0.1,  0.5, 1, 0.75, 1, 0, 0, 0, 0, 1, 0, 0, 1000, 26972),
(0.1,  0.5, 1, 0.75, 1, 0, 0, 0, 0, 1, 0, 0, 1002, 26972);

DELETE FROM `light` WHERE `ID` = 9331;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9331, -7100, 800, 0, 1200, 1700, 1, 253, 207, 408, 207, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` = 9000465;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000465, 1556783290, 9331, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 62;
