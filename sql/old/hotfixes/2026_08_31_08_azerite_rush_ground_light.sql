-- ==========================================================================================
-- Azerite Rush - a ground light with distant fog
--
-- Arathi Basin's own light (326, parameters 311) sets FogEnd 4000 and FogScaler 0.1: the fog
-- starts at 400 yards and only turns solid at 4000, so it is spread far too thin to hide
-- anything. Above the airship altitude light 7321 covers everything, but below it the horizon
-- and the edge of the ground were bare.
--
-- Light 9301 is Arathi's own sky, colour for colour, with two values changed:
--   FogEnd    4000 -> 2000   solid twice as close
--   FogScaler  0.1 -> 0.5    nothing at all before 1000 yards
-- The basin is roughly 700 yards across, so the whole playfield stays clear and only what lies
-- beyond it disappears. FogEnd is the knob:
--   UPDATE hotfixes_legion.light_data SET FogEnd = 1500 WHERE LightParamID = 3701;
--   UPDATE world_legion.version SET hotfix_cache_id = hotfix_cache_id + 1;
--
-- Skybox 235 is taken from the airship light rather than Arathi's own 0: it was preferred in
-- game, and using the same one on both sides means crossing the altitude changes the fog alone
-- instead of swapping the sky at the same time. Put it back to 0 for the original sky.
--
-- Client maxima: LightParams 3638, LightData 38892, Light 9249 - every id below is free.
-- ==========================================================================================

DELETE FROM `light_params` WHERE `ID` = 3701;
INSERT INTO `light_params`
  (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
   `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
   `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`) VALUES
(3701, 0.500, 0.500, 1.000, 0.750, 1.000, 0, 0, 0, 235, 0, 0, 0);

-- The three entries of the day, copied from LightData 25848, 25849 and 25850.
DELETE FROM `light_data` WHERE `LightParamID` = 3701;
INSERT INTO `light_data`
  (`ID`, `DirectColor`, `AmbientColor`, `SkyTopColor`, `SkyMiddleColor`, `SkyBand1Color`, `SkyBand2Color`,
   `SkySmogColor`, `SkyFogColor`, `SunColor`, `CloudSunColor`, `CloudEmissiveColor`,
   `CloudLayer1AmbientColor`, `CloudLayer2AmbientColor`, `OceanCloseColor`, `OceanFarColor`,
   `RiverCloseColor`, `RiverFarColor`, `ShadowOpacity`, `FogEnd`, `FogScaler`, `CloudDensity`,
   `FogDensity`, `FogHeight`, `FogHeightScaler`, `FogHeightDensity`, `SunFogAngle`,
   `EndFogColorDistance`, `SunFogColor`, `EndFogColor`, `FogHeightColor`, `ColorGradingFileDataID`,
   `HorizonAmbientColor`, `GroundAmbientColor`, `LightParamID`, `Time`) VALUES
(900110,  2917558, 3286074, 8254925, 3185252, 2051381, 1521706, 2108961, 2303527, 11924412,  921102, 0, 0, 12346, 3155989, 1643545, 2432784, 1643545, 5921370, 2000, 0.5, 0.5, 4.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3701,    0),
(900111, 10651805, 5259087,       0, 2770239, 5272162, 7257263, 6315122, 2300965, 12839619, 3697492, 0, 0, 23420, 5784628, 2300965, 5390385, 2300965, 4342338, 2000, 0.5, 0.5, 4.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3701, 1440),
(900112,  2983093, 3286074, 8123082, 3119459, 2051381, 1587499, 2108961, 2303270, 12187583,  921358, 0, 0, 12346, 3155989, 1643545, 2432784, 1643545, 5855577, 2000, 0.5, 0.4, 4.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3701, 2870);

-- Global on Arathi Basin: origin coordinates and no falloff is what makes a light cover a map.
DELETE FROM `light` WHERE `ID` = 9301;
INSERT INTO `light`
  (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`, `ContinentID`,
   `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
   `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`) VALUES
(9301, 0, 0, 0, 0, 0, 529, 3701, 3701, 3701, 3701, 3701, 3701, 3701, 3701);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000278 AND 9000282;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000278, 1556783290,   9301, 0, 0),
(9000279, 3330215320,   3701, 0, 0),
(9000280,  181829311, 900110, 0, 0),
(9000281,  181829311, 900111, 0, 0),
(9000282,  181829311, 900112, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 11;
