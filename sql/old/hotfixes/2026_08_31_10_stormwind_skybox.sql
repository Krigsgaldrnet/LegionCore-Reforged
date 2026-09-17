-- ==========================================================================================
-- Stormwind under the Azsuna sky
--
-- Stormwind has no lighting of its own: `.debug fogwhere` in the Trade District returns a single
-- record, light 1, the global light of the Eastern Kingdoms. Editing it would have repainted the
-- sky of the whole continent, from Loch Modan to Stranglethorn.
--
-- So a local light is added over the city instead. It is light 1 copied whole - all fourteen
-- entries of its day cycle, colour for colour, glow, HighlightSky included - with one field
-- changed: LightSkyboxID 0 becomes 235, the sky that comes with Vault of the Wardens in Azsuna.
-- The city keeps its own light and its own fog; only what is above changes.
--
-- Centred on (-8850, 620, 100), full effect within 500 yards and fading out to 800, which covers
-- the city and stops before Elwynn. Both radii are one UPDATE away if the edge shows.
--
-- Nothing here touches the battleground: that one sends its own light per player and never
-- crosses paths with this.
-- ==========================================================================================

DELETE FROM `light_params` WHERE `ID` = 3702;
INSERT INTO `light_params`
  (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
   `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
   `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`) VALUES
(3702, 0.400, 0.500, 1.000, 0.650, 1.000, 0, 0, 0, 235, 1, 0, 0);

DELETE FROM `light_data` WHERE `LightParamID` = 3702;
INSERT INTO `light_data`
  (`ID`, `DirectColor`, `AmbientColor`, `SkyTopColor`, `SkyMiddleColor`, `SkyBand1Color`, `SkyBand2Color`, `SkySmogColor`, `SkyFogColor`, `SunColor`, `CloudSunColor`, `CloudEmissiveColor`, `CloudLayer1AmbientColor`, `CloudLayer2AmbientColor`, `OceanCloseColor`, `OceanFarColor`, `RiverCloseColor`, `RiverFarColor`, `ShadowOpacity`, `FogEnd`, `FogScaler`, `CloudDensity`, `FogDensity`, `FogHeight`, `FogHeightScaler`, `FogHeightDensity`, `SunFogAngle`, `EndFogColorDistance`, `SunFogColor`, `EndFogColor`, `FogHeightColor`, `ColorGradingFileDataID`, `HorizonAmbientColor`, `GroundAmbientColor`, `LightParamID`, `Time`) VALUES
(900200, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 3031393, 2178607, 3096, 1719326, 3165520, 6052956, 18000, 0, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 0),
(900201, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 12875, 2178607, 3096, 1719326, 3165520, 6052956, 17200, 0.05, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 360),
(900202, 10961664, 8491682, 3756125, 5468293, 12411202, 16752679, 16763440, 3359821, 16765590, 11057344, 0, 14115868, 2116719, 5982274, 1323055, 3095095, 3033933, 7237230, 16000, 0, 0.5, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 720),
(900203, 6968898, 8361386, 8009, 5406631, 10083573, 11524832, 11842740, 5077135, 16775134, 11584215, 0, 4417402, 6390455, 1133401, 7465, 2706513, 1715763, 5066061, 18000, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 1440),
(900204, 8142352, 9932963, 3093822, 6838913, 10840915, 11891522, 13074987, 5979467, 16742171, 16766112, 0, 2959418, 6115448, 4212812, 859952, 2572860, 2374204, 7237230, 17333.3, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2160),
(900205, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 6115448, 5916742, 1385013, 1719326, 3165520, 6052956, 18000, 0, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2520),
(900206, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 5065584, 2178607, 3096, 1719326, 3165520, 6052956, 18000, 0, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2640),
(900207, 7621162, 9081510, 8009, 5406631, 9873837, 11642513, 12426096, 5462637, 16765590, 16764308, 0, 5923686, 0, 3492175, 663342, 2639686, 1979191, 6118749, 17500, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 1980),
(900208, 9255936, 9932963, 3093822, 6707587, 11952195, 11891522, 13074987, 5979467, 16769705, 16766112, 0, 3024957, 0, 3754318, 728879, 2572860, 2374204, 7237230, 17444.4, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2040),
(900209, 7094561, 9932963, 3093822, 7036032, 9729893, 11891522, 13074987, 5979467, 16769705, 16766112, 0, 2894136, 0, 4802634, 1056818, 2572860, 2374204, 7237230, 17222.2, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2280),
(900210, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 0, 5589063, 1253684, 1719326, 3165520, 6052956, 18000, 0, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2460),
(900211, 8338957, 9932963, 3093822, 6838913, 10971473, 11891522, 13074987, 5979467, 16737796, 16766112, 0, 2959418, 0, 4147276, 859952, 2572860, 2374204, 7237230, 17351.9, 0.25, 0.5, 4.5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 2140),
(900212, 2377316, 3561580, 0, 3103, 467012, 993875, 929609, 265247, 15266303, 658713, 0, 996209, 0, 2178607, 3096, 1719326, 3165520, 6052956, 16800, 0.075, 0.5, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 540),
(900213, 7034662, 7373976, 8009, 7971254, 9285569, 10402762, 10402762, 9748180, 16767137, 10402762, 0, 10402762, 0, 5130309, 1059886, 3030075, 2770504, 6842472, 16333.3, 0, 0.4, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3702, 840);

DELETE FROM `light` WHERE `ID` = 9302;
INSERT INTO `light`
  (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`, `ContinentID`,
   `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
   `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`) VALUES
(9302, -8850, 620, 100, 500, 800, 0, 3702, 3702, 3702, 3702, 3702, 3702, 3702, 3702);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000283 AND 9000298;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000283, 1556783290,   9302, 0, 0),
(9000284, 3330215320,   3702, 0, 0),
(9000285,  181829311, 900200, 0, 0),
(9000286,  181829311, 900201, 0, 0),
(9000287,  181829311, 900202, 0, 0),
(9000288,  181829311, 900203, 0, 0),
(9000289,  181829311, 900204, 0, 0),
(9000290,  181829311, 900205, 0, 0),
(9000291,  181829311, 900206, 0, 0),
(9000292,  181829311, 900207, 0, 0),
(9000293,  181829311, 900208, 0, 0),
(9000294,  181829311, 900209, 0, 0),
(9000295,  181829311, 900210, 0, 0),
(9000296,  181829311, 900211, 0, 0),
(9000297,  181829311, 900212, 0, 0),
(9000298,  181829311, 900213, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 13;
