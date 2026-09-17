-- ---------------------------------------------------------------------------------------------
-- Arathi Basin: the stormy skybox, without the fog that came with it.
--
-- The Vault of the Wardens sky was borrowed by overriding the map's light with 7321, but that
-- light is a dungeon one: all three parameter sets carrying skybox 235 (1887, 2717, 2778) have
-- FogEnd = 40, against 4000 and 40000 for Arathi's own lights. The fog is not a setting to turn
-- down, it is what those lights are.
--
-- So the skybox moves instead of the light. Map 529 already has a local light, 327, reaching
-- 788-1067 yards from (945,945), which covers the whole playable area, and it is the only light
-- in the client using parameter set 313. Giving that set the skybox keeps every one of Arathi's
-- own light and fog values and changes nothing anywhere else.
--
-- A hotfix row replaces the whole record, so every other field is copied from the client's own.
-- TableHash 4135445167 is LightParams (0xF67DE2AF).
-- ---------------------------------------------------------------------------------------------

DELETE FROM `light_params` WHERE `ID` = 313;
INSERT INTO `light_params` (`ID`, `Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`,
                            `OceanDeepAlpha`, `OverrideCelestialSphere1`, `OverrideCelestialSphere2`,
                            `OverrideCelestialSphere3`, `LightSkyboxID`, `HighlightSky`, `CloudTypeID`,
                            `Flags`, `VerifiedBuild`) VALUES
(313, 0.65, 0.5, 1, 0.75, 1, 0, 0, 0, 235, 1, 0, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000330;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000330, 4135445167, 313, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 31;
