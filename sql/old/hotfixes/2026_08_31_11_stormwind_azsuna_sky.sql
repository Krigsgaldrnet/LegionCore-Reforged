-- ==========================================================================================
-- Stormwind gets Azsuna's sky, the real one
--
-- The first attempt copied skybox 235, which belongs to Vault of the Wardens - the demon hunter
-- intro, an instanced map that happens to sit in Azsuna. It is not what the zone itself shows.
--
-- Azsuna has no skybox at all: `.debug fogparams 1806` returns skybox 0. Its whole look comes
-- from colours - zenith, horizon bands, smog, fog, cloud layers - plus HighlightSky and a cloud
-- density of 3. There is no model to borrow, only a palette.
--
-- So light 9302 now carries Azsuna's palette instead: the seven entries of its day cycle, copied
-- field for field from LightParams 1806, the global light of the Broken Isles.
--
-- Worth knowing: DirectColor and AmbientColor are in there too, so this does not merely repaint
-- the vault of the sky - Stormwind will be lit like Azsuna, in its cold violet cast. That is the
-- whole point of the request, but it is a change of mood and not a backdrop swap.
--
-- The fourteen rows of the first attempt are marked Deleted so the client drops them; leaving
-- them would give parameter set 3702 two conflicting day cycles.
-- ==========================================================================================

DELETE FROM `light_params` WHERE `ID` = 3702;
INSERT INTO `light_params`
  (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
   `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
   `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`) VALUES
(3702, 0.100, 0.500, 1.000, 0.650, 1.000, 0, 0, 0, 0, 1, 0, 0);

DELETE FROM `light_data` WHERE `LightParamID` = 3702;
INSERT INTO `light_data`
  (`ID`, `DirectColor`, `AmbientColor`, `SkyTopColor`, `SkyMiddleColor`, `SkyBand1Color`, `SkyBand2Color`, `SkySmogColor`, `SkyFogColor`, `SunColor`, `CloudSunColor`, `CloudEmissiveColor`, `CloudLayer1AmbientColor`, `CloudLayer2AmbientColor`, `OceanCloseColor`, `OceanFarColor`, `RiverCloseColor`, `RiverFarColor`, `ShadowOpacity`, `FogEnd`, `FogScaler`, `CloudDensity`, `FogDensity`, `FogHeight`, `FogHeightScaler`, `FogHeightDensity`, `SunFogAngle`, `EndFogColorDistance`, `SunFogColor`, `EndFogColor`, `FogHeightColor`, `ColorGradingFileDataID`, `HorizonAmbientColor`, `GroundAmbientColor`, `LightParamID`, `Time`) VALUES
(900220, 3687503, 9276813, 0, 6724, 996947, 996947, 929609, 929609, 15266303, 3301764, 0, 1194065, 3031393, 2178607, 3096, 1719326, 2570031, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3702, 0),
(900221, 4540749, 7773885, 0, 5952, 732232, 931158, 931158, 929609, 15266303, 3825536, 0, 1262417, 12875, 2178607, 3096, 2572860, 2374204, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3702, 360),
(900222, 10961664, 8491682, 2312788, 4492416, 13793608, 16755520, 16763468, 6126957, 16765590, 16757564, 0, 4498091, 2116719, 5982274, 1323055, 3095095, 3033933, 7237230, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 6126957, 0, 0, 0, 0, 3702, 720),
(900223, 3813156, 8361386, 8009, 3842767, 10083573, 11524832, 11842740, 5077135, 16775134, 16762762, 0, 2845060, 6390455, 1133401, 7465, 2706513, 1715763, 5066061, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5077135, 0, 0, 0, 0, 3702, 1440),
(900224, 5978658, 9343397, 2043201, 5927834, 9803925, 11703671, 12620377, 5656673, 16771514, 16764824, 0, 6971740, 6115448, 4278604, 860208, 2573635, 2110776, 6447714, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5656673, 0, 0, 0, 0, 3702, 2160),
(900225, 7094561, 9932963, 3093822, 7036032, 9729893, 11891522, 13074987, 5979467, 16769705, 16766112, 0, 9067848, 6115448, 5916742, 1385013, 2572860, 2374204, 7237230, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 5979467, 0, 0, 0, 0, 3702, 2520),
(900226, 3028799, 7834781, 0, 6469, 1063513, 1063513, 996432, 929609, 15266303, 3301764, 0, 1194065, 5065584, 2178607, 3096, 1719326, 2570031, 6052956, 0, 0.25, 0.5, 3, 0, 0, 0, 1, 800, 0, 929609, 0, 0, 0, 0, 3702, 2640);

-- The first attempt's rows, withdrawn from the client.
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000285 AND 9000305;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000285,  181829311, 900200, 0, 1),
(9000286,  181829311, 900201, 0, 1),
(9000287,  181829311, 900202, 0, 1),
(9000288,  181829311, 900203, 0, 1),
(9000289,  181829311, 900204, 0, 1),
(9000290,  181829311, 900205, 0, 1),
(9000291,  181829311, 900206, 0, 1),
(9000292,  181829311, 900207, 0, 1),
(9000293,  181829311, 900208, 0, 1),
(9000294,  181829311, 900209, 0, 1),
(9000295,  181829311, 900210, 0, 1),
(9000296,  181829311, 900211, 0, 1),
(9000297,  181829311, 900212, 0, 1),
(9000298,  181829311, 900213, 0, 1),
(9000299,  181829311, 900220, 0, 0),
(9000300,  181829311, 900221, 0, 0),
(9000301,  181829311, 900222, 0, 0),
(9000302,  181829311, 900223, 0, 0),
(9000303,  181829311, 900224, 0, 0),
(9000304,  181829311, 900225, 0, 0),
(9000305,  181829311, 900226, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 14;
