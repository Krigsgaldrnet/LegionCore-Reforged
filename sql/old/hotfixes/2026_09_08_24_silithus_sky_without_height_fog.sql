-- The fog over the crater is height fog, and it came from the parameter set I chose.
--
-- Read out of LightData.db2, the numbers say it plainly:
--
--   param   FogEnd  FogHeight  FogHeightScaler  FogHeightDensity
--     192    18000          0                0                 0     <- Kalimdor's default
--     254    14000        350      0.000666667               0.5     <- what light 9330 was using
--    1002    90000          0                0                 0
--
-- 254 is the palette of northern Silithus, where the ground sits around zero. It carries height
-- fog from 350 down, which costs nothing on a plateau. The crater floor is at -100, four hundred
-- and fifty units below that plane, so the same palette buries it. Before light 9330 existed the
-- crater fell back to 192, Kalimdor's default, which has no height fog at all - which is exactly
-- why the fog appeared the day the light did.
--
-- So the sky moves to 1002. It is Silithus's own too - the parameter of the five lights in the west
-- of the zone, and of 9152 on the Wound's terrain map - it already carries HighlightSky, and it has
-- no height fog and a FogEnd of 90000, so the crater is clear to the horizon. 254 goes back exactly
-- as Blizzard wrote it.
--
-- The far-north light 250 therefore loses the sky and the western lights gain it: 2759, 2760, 2765,
-- 2766 and 2767, between -8400 and -9500, a strip of Silithus nobody has asked about. It is the
-- same trade as before, moved.
--
-- TableHash 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_params` WHERE `ID` IN (254, 1002);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0,   0, 0, 0, 0,  254, 26972),
(0.1,  0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0, 1002, 26972);

DELETE FROM `light` WHERE `ID` = 9330;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9330, -7100, 800, 0, 1200, 1700, 1, 1002, 207, 1002, 207, 3, 0, 0, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 64;
