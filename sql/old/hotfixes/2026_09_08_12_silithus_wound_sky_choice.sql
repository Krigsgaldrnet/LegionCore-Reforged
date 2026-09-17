-- Two candidate skies for the Wound, both declared, one in use.
--
-- 903 is the broken Icecrown sky, 904 the Dragonflight timeway, 905 the Castle Nathria one. All
-- three carry only constant weight tracks, so none of them has a day and night cycle to freeze.
--
-- Only the LightParams record decides which is drawn, so switching is one UPDATE and needs no
-- republication - the three models are all served.
DELETE FROM `light_skybox` WHERE `ID` IN (904, 905);
INSERT INTO `light_skybox` (`ID`, `Name`, `CelestialSkyboxFileDataID`, `SkyboxFileDataID`, `Flags`, `VerifiedBuild`) VALUES
(904, 'Environments\Stars\10xp_timewaysky01.m2', 0, 4909057, 7, 0),
(905, 'Environments\Stars\9cas_sky01.m2',        0, 3164522, 7, 0);

UPDATE `light_params` SET `LightSkyboxID` = 904 WHERE `ID` = 3706;

DELETE FROM `hotfix_data` WHERE `Id` IN (9000449, 9000450);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000449, 3546600791, 904, 0, 0),
(9000450, 3546600791, 905, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 52;
