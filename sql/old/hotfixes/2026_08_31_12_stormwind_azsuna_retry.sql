-- ==========================================================================================
-- Stormwind under Azsuna's palette, second attempt - without deleting anything
--
-- The first attempt was sound in the database and wrong in the method. `.debug fogwhere` in the
-- city returns light 9302 at 232 yards inside a 500 yard core, so the record was found and
-- selected; what the client could not do was resolve a day cycle for parameter set 3702, and it
-- fell back to a default - daylight at four in the morning under the original sky.
--
-- The cause was withdrawing fourteen rows with Deleted while adding seven under new ids in the
-- same breath. This file deletes nothing: a fresh parameter set 3703, fresh row ids, the light
-- repointed at it. The stale records stay behind unreferenced and do no harm.
--
-- To be clear about what this is: Azsuna has no skybox, LightSkyboxID is 0. There is no model to
-- borrow. Everything - the violet clouds, the streaks, the depth - is colour, which is why the
-- whole palette is copied and why Stormwind will be lit in Azsuna's cold cast rather than merely
-- roofed with its sky. Skybox 235, the orange lightning of Vault of the Wardens, is deliberately
-- not used here.
-- ==========================================================================================

DELETE FROM `light_params` WHERE `ID` = 3703;
INSERT INTO `light_params`
  (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
   `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
   `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`) VALUES
(3703, 0.100, 0.500, 1.000, 0.650, 1.000, 0, 0, 0, 0, 1, 0, 0);

DELETE FROM `light_data` WHERE `LightParamID` = 3703;
INSERT INTO `light_data`
  (`ID`, `DirectColor`, `AmbientColor`, `SkyTopColor`, `SkyMiddleColor`, `SkyBand1Color`, `SkyBand2Color`, `SkySmogColor`, `SkyFogColor`, `SunColor`, `CloudSunColor`, `CloudEmissiveColor`, `CloudLayer1AmbientColor`, `CloudLayer2AmbientColor`, `OceanCloseColor`, `OceanFarColor`, `RiverCloseColor`, `RiverFarColor`, `ShadowOpacity`, `FogEnd`, `FogScaler`, `CloudDensity`, `FogDensity`, `FogHeight`, `FogHeightScaler`, `FogHeightDensity`, `SunFogAngle`, `EndFogColorDistance`, `SunFogColor`, `EndFogColor`, `FogHeightColor`, `ColorGradingFileDataID`, `HorizonAmbientColor`, `GroundAmbientColor`, `LightParamID`, `Time`) VALUES
(900240, 3687503, 9276813, 0, 6724, 996947, 996947, 929609, 929609, 15266303, 3301764, 0, 1194065, 3031393, 2178607, 3096, 1719326, 2570031, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3703, 0),
(900241, 4540749, 7773885, 0, 5952, 732232, 931158, 931158, 929609, 15266303, 3825536, 0, 1262417, 12875, 2178607, 3096, 2572860, 2374204, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3703, 360),
(900242, 10961664, 8491682, 2312788, 4492416, 13793608, 16755520, 16763468, 6126957, 16765590, 16757564, 0, 4498091, 2116719, 5982274, 1323055, 3095095, 3033933, 7237230, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 6126957, 0, 0, 0, 0, 3703, 720),
(900243, 3813156, 8361386, 8009, 3842767, 10083573, 11524832, 11842740, 5077135, 16775134, 16762762, 0, 2845060, 6390455, 1133401, 7465, 2706513, 1715763, 5066061, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5077135, 0, 0, 0, 0, 3703, 1440),
(900244, 5978658, 9343397, 2043201, 5927834, 9803925, 11703671, 12620377, 5656673, 16771514, 16764824, 0, 6971740, 6115448, 4278604, 860208, 2573635, 2110776, 6447714, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5656673, 0, 0, 0, 0, 3703, 2160),
(900245, 7094561, 9932963, 3093822, 7036032, 9729893, 11891522, 13074987, 5979467, 16769705, 16766112, 0, 9067848, 6115448, 5916742, 1385013, 2572860, 2374204, 7237230, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5979467, 0, 0, 0, 0, 3703, 2520),
(900246, 3028799, 7834781, 0, 6469, 1063513, 1063513, 996432, 929609, 15266303, 3301764, 0, 1194065, 5065584, 2178607, 3096, 1719326, 2570031, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3703, 2640);

UPDATE `light` SET `LightParamsID1` = 3703, `LightParamsID2` = 3703, `LightParamsID3` = 3703,
                   `LightParamsID4` = 3703, `LightParamsID5` = 3703, `LightParamsID6` = 3703,
                   `LightParamsID7` = 3703, `LightParamsID8` = 3703
WHERE `ID` = 9302;

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000306 AND 9000325;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000306, 3330215320, 3703, 0, 0),
(9000310,  181829311, 900240, 0, 0),
(9000311,  181829311, 900241, 0, 0),
(9000312,  181829311, 900242, 0, 0),
(9000313,  181829311, 900243, 0, 0),
(9000314,  181829311, 900244, 0, 0),
(9000315,  181829311, 900245, 0, 0),
(9000316,  181829311, 900246, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 15;
