-- ---------------------------------------------------------------------------------------------
-- Give Westfall the sky of Drustvar.
--
-- Two lights cover Westfall, 4 and 8, and between them they use exactly four parameter sets -
-- 17 clear, 18 and 25 underwater, 497 storm - which no other light on any map refers to. So the
-- sky can be swapped by editing 17 and 497 in place rather than by inventing new lights: nothing
-- else inherits the change. Slot 4, the death parameters, is the shared record 3 and is left
-- alone.
--
-- The skybox record is new: 7.3.5 stops at LightSkybox 418, and 8DRU Sky is BfA's 408. Its model
-- 1726751 (environments/stars/8dru_sky01.m2) is served by CASCHost under that same identifier.
-- Flags 7 matches what BfA ships for it.
--
-- Only the skybox moves. Fog, glow and water alphas stay Westfall's own, so the ground keeps its
-- colour and only the dome above changes.
--
-- TableHash 3546600791 is LightSkybox and 3330215320 is LightParams. These are the header's
-- TableHash field, not its LayoutHash: the server keys its stores by the former, and a row
-- carrying the latter is dropped with "references unknown DB2 store".
-- ---------------------------------------------------------------------------------------------

DELETE FROM `light_skybox` WHERE `ID` = 901;
INSERT INTO `light_skybox` (`ID`, `Name`, `CelestialSkyboxFileDataID`, `SkyboxFileDataID`, `Flags`, `VerifiedBuild`) VALUES
(901, 'Environments\Stars\8dru_sky01.m2', 0, 1726751, 7, 0);

DELETE FROM `light_params` WHERE `ID` IN (17, 497);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.5, 0.5, 1, 0.75, 1, 0, 0, 0, 901, 1, 0, 0,  17, 26972),
(0.5, 0.5, 1, 0.75, 1, 0, 0, 0, 901, 1, 0, 0, 497, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000394, 9000395, 9000396);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000394, 3546600791, 901, 0, 0),
(9000395, 3330215320,  17, 0, 0),
(9000396, 3330215320, 497, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 36;
