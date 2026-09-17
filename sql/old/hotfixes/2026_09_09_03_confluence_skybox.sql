-- Sky for map 2678: the Dawn of the Infinite skybox.
--
-- Three rows, because that is the chain the client walks: a Light placed on the map points at a
-- LightParams, and only a LightParams carries a LightSkyboxID.
--
-- LightSkybox names its model by FileDataID in 7.3.5, not by path - the Name column is empty on
-- every one of Blizzard's 234 rows. The id is the model's own, 4909057, already served under it.
--
-- The Light has falloff 0/0 and sits at the origin, which is what makes it the map's default rather
-- than a local one: GetDefaultMapLight looks for exactly that. All eight LightParams slots point at
-- the same set, so the sky holds through every weather and time of day.
--
-- The LightParams is new and therefore has no LightData rows, so colours and fog fall back to the
-- client's defaults. That is deliberate: cloning LightData does not survive this core's hotfix
-- serialisation - its parent column is not written back where the client expects it, and three
-- attempts produced light the client refused. The scalar values here are the ones Blizzard uses
-- almost everywhere (water 0.5/1.0, ocean 0.75/1.0); the real lights of this zone come later.
--
-- TableHash 3546600791 LightSkybox, 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_skybox` WHERE `ID` = 2678;
INSERT INTO `light_skybox` (`ID`, `Name`, `CelestialSkyboxFileDataID`, `SkyboxFileDataID`, `Flags`,
                            `VerifiedBuild`) VALUES
(2678, '', 0, 4909057, 0, 26972);

DELETE FROM `light_params` WHERE `ID` = 2678;
INSERT INTO `light_params` (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`,
                            `OceanDeepAlpha`, `OverrideCelestialSphere1`, `OverrideCelestialSphere2`,
                            `OverrideCelestialSphere3`, `LightSkyboxID`, `HighlightSky`,
                            `CloudTypeID`, `Flags`, `VerifiedBuild`) VALUES
(2678, 0.5, 0.5, 1, 0.75, 1, 0, 0, 0, 2678, 0, 0, 0, 26972);

DELETE FROM `light` WHERE `ID` = 9500;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`,
                     `GameFalloffEnd`, `ContinentID`, `LightParamsID1`, `LightParamsID2`,
                     `LightParamsID3`, `LightParamsID4`, `LightParamsID5`, `LightParamsID6`,
                     `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9500, 0, 0, 0, 0, 0, 2678, 2678, 2678, 2678, 2678, 2678, 2678, 2678, 2678, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000483, 9000484, 9000485);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000483, 3546600791, 2678, 0, 0),
(9000484, 3330215320, 2678, 0, 0),
(9000485, 1556783290, 9500, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 70;
