-- ==========================================================================================
-- The broken Icecrown sky over the Wound, and only there.
--
-- Lights are attached to a map, and the Wound is a map: the phase swaps terrain to 1817. So a
-- light created on 1817 reaches exactly the players standing in the Wound and nobody in old
-- Silithus, which is map 1. No phase-aware lighting is needed - the terrain swap already draws
-- the line.
--
-- Map 1817 owns three lights, 9150 to 9152, but no default, so most of the zone falls back to
-- whatever answers for map 1817 elsewhere. A default light is added - falloff 0/0, the convention
-- map 530 uses for its own record 374 - and the three existing ones are repointed, so no pocket
-- keeps another sky.
--
-- The parameters those three use cannot be edited: 254, 253, 425, 408, 1000, 1002 and 207 are all
-- shared with map 1, which is old Silithus. Editing them would repaint the very zone this is meant
-- to leave alone. New parameters are created instead and the lights point at them.
--
-- 3706 sits in the clear slot AND the storm slot of every light, so weather cannot swap the sky
-- out. The model needs nothing frozen: its six weight tracks already hold a single key each, so it
-- has no day and night cycle of its own. Submesh 11 is emptied in the skin, which is what
-- wow.export numbers geoset 11.
--
-- TableHash 3546600791 LightSkybox, 3330215320 LightParams, 1556783290 Light.
-- ==========================================================================================

DELETE FROM `light_skybox` WHERE `ID` = 903;
INSERT INTO `light_skybox` (`ID`, `Name`, `CelestialSkyboxFileDataID`, `SkyboxFileDataID`, `Flags`, `VerifiedBuild`) VALUES
(903, 'Environments\\Stars\\9xp_icecrown_brokensky.m2', 0, 3159936, 7, 0);

-- Copied from 254, the parameter the largest of the three lights already uses, so glow and water
-- alpha stay as they were; only the skybox is added.
DELETE FROM `light_params` WHERE `ID` = 3706;
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0, 903, 1, 0, 0, 3706, 26972);

-- The map-wide default, plus the three local lights repointed. 3706 fills the clear and the storm
-- slots of each; the underwater slots keep what they had.
DELETE FROM `light` WHERE `ID` IN (9320, 9150, 9151, 9152);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9320,     0,     0,   0,   0,    0, 1817, 3706,  11, 3706,  11, 3, 0, 0, 0, 0),
(9150, -6158,  3473,   0, 897, 1334, 1817, 3706, 207, 3706, 207, 3, 0, 0, 0, 0),
(9151, -6419,  -233,   0, 196,  306, 1817, 3706, 207, 3706, 207, 3, 0, 0, 0, 0),
(9152, -8401,  -209, 200, 221,  322, 1817, 3706, 946, 3706,  11, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000441 AND 9000446;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000441, 3546600791,  903, 0, 0),
(9000442, 3330215320, 3706, 0, 0),
(9000443, 1556783290, 9320, 0, 0),
(9000444, 1556783290, 9150, 0, 0),
(9000445, 1556783290, 9151, 0, 0),
(9000446, 1556783290, 9152, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 48;
