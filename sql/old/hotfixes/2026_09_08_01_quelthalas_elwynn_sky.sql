-- ==========================================================================================
-- Give Quel'Thalas the 12.x Elwynn sky.
--
-- Unlike Elwynn and Stormwind, which sat on Azeroth's default light and needed local lights added,
-- Quel'Thalas already owns twelve of them on map 530 - 443 covers the heart of the zone with a
-- reach of 2028, the other eleven fill in. So no light is created here: only the parameters they
-- point at are repointed, which is both smaller and safer.
--
-- Which parameters was measured, not assumed. Of the ten used by those twelve lights, four are
-- exclusive to Quel'Thalas and three of them sit in a sky slot:
--
--   399  clear sky of ten lights, map 530 only          -> repointed
--   442  clear sky of the three eastern lights, 530 only -> repointed
--   433  clear sky of lights 450 and 474, 530 only      -> repointed
--   383  the underwater slot, 530 only                  -> left alone, no sky is drawn there
--
-- The rest are shared and stay untouched: 407 and 448 also serve maps 0 and 568, and 3, 9 and 11
-- are the global defaults behind thousands of lights. The visible consequence is small and known:
-- light 472, in the far south, keeps its old clear sky because it draws it from 448, and light 450
-- keeps its old storm sky, which comes from 407.
--
-- Skybox 902 is new. The model carries its own day, night and sunrise textures, blended by the
-- client on the hour, so the daylight cycle and the weather are untouched - only what is painted
-- on the dome changes. Every LightParams field but LightSkyboxID is copied from the record it
-- replaces, so glow, water alpha and fog stay exactly as Quel'Thalas has always had them.
--
-- 7355775 is the model's own FileDataID: it is served by CASCHost under that identifier, which the
-- reservation in root_entries preserved.
--
-- TableHash 3330215320 is LightParams. LightSkybox cannot be created from C++, only from SQL.
-- ==========================================================================================

DELETE FROM `light_skybox` WHERE `ID` = 902;
INSERT INTO `light_skybox` (`ID`, `Name`, `CelestialSkyboxFileDataID`, `SkyboxFileDataID`, `Flags`, `VerifiedBuild`) VALUES
(902, 'Environments\\Stars\\12elw_sky01.m2', 0, 7355775, 7, 0);

DELETE FROM `light_params` WHERE `ID` IN (399, 442, 433);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.5,  0.5, 1, 0.5,  1, 0, 0, 0, 902, 0, 0, 0, 399, 26972),
(0.25, 0.5, 1, 0.75, 1, 0, 0, 0, 902, 1, 0, 0, 442, 26972),
(0.5,  0.5, 1, 0.75, 1, 0, 0, 0, 902, 0, 0, 0, 433, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000428, 9000429, 9000430);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000428, 3330215320, 399, 0, 0),
(9000429, 3330215320, 442, 0, 0),
(9000430, 3330215320, 433, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 41;
