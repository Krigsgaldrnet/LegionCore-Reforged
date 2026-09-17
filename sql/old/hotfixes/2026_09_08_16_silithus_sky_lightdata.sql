-- The new light parameter had no colours, so there was nothing to draw the sky with.
--
-- LightParams holds almost nothing itself - glow, water alphas, which skybox. Every colour of the
-- vault, every fog distance, the ambient and direct light all live in LightData, keyed by
-- LightParamID, one row per time of day. Record 3706 was created out of thin air and never given
-- any, so the client had an empty day cycle: hence fog and no skybox at all. The skybox is blended
-- against those sky colours; with none, there is nothing to blend it into.
--
-- This is the same recipe the Stormwind sky used and it is written down there too - a new
-- LightParams always comes with its LightData rows.
--
-- The palette is Silithus's own, LightParams 254, the parameter the largest of the three lights of
-- map 1817 already uses. Only the skybox differs from it, so the zone keeps its light and its fog
-- and gains a sky.
--
-- Read straight out of ClientData/dbc/frFR/LightData.db2, whose rows carry their LightParamID in
-- the relationship block rather than in the record. The decoder was checked before use: run on
-- LightParams 1806, it reproduces the Broken Isles rows already in this table, field for field,
-- which is what caught a one-column shift between ShadowOpacity and EndFogColorDistance.
--
-- The rows are numbered from 900260. The first attempt used 900240, which belongs to parameter
-- 3703 since the Stormwind sky, and the DELETE above only clears 3706 - so the insert collided on
-- the primary key and the whole startup stopped. 900220 to 900246 are taken.
--
-- TableHash 181829311 LightData.

DELETE FROM `light_data` WHERE `LightParamID` = 3706;
INSERT INTO `light_data`
  (`ID`, `DirectColor`, `AmbientColor`, `SkyTopColor`, `SkyMiddleColor`, `SkyBand1Color`, `SkyBand2Color`,
   `SkySmogColor`, `SkyFogColor`, `SunColor`, `CloudSunColor`, `CloudEmissiveColor`, `CloudLayer1AmbientColor`,
   `CloudLayer2AmbientColor`, `OceanCloseColor`, `OceanFarColor`, `RiverCloseColor`, `RiverFarColor`,
   `ShadowOpacity`, `FogEnd`, `FogScaler`, `CloudDensity`, `FogDensity`, `FogHeight`, `FogHeightScaler`,
   `FogHeightDensity`, `SunFogAngle`, `EndFogColorDistance`, `SunFogColor`, `EndFogColor`, `FogHeightColor`,
   `ColorGradingFileDataID`, `HorizonAmbientColor`, `GroundAmbientColor`, `LightParamID`, `Time`) VALUES
(900260, 7175525, 1067064, 7506285, 3240294, 5402977, 3822920, 3494977, 2638642, 14743551, 10662214, 0, 1788448, 12346, 2635575, 4087129, 4081174, 5074517, 7631988, 14000, 0, 0.5, 4.5, 350, 0.000666667, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 3706, 0),
(900261, 10397596, 5533493, 16056312, 15925215, 9421427, 6654038, 5207123, 5207123, 14743551, 4883022, 0, 7187340, 0, 3688006, 5335912, 4081174, 5865315, 4342338, 14000, 0, 0.5, 4.5, 350, 0.000666667, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 3706, 1440),
(900262, 7175525, 1067063, 7572078, 3371623, 5402977, 3822920, 3494977, 2638642, 14743551, 10530886, 0, 1788705, 12089, 2635575, 4087129, 4081174, 5074517, 7566195, 14000, 0, 0.5, 4.5, 350, 0.000666667, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 3706, 2870);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000451 AND 9000453;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000451, 181829311, 900260, 0, 0),
(9000452, 181829311, 900261, 0, 0),
(9000453, 181829311, 900262, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 56;
