-- Affichage de 12fx_custom_voidcosmic_blackhole_active_02.m2 (FileDataID 7290031).
-- Boîte relevée sur les sommets réellement dessinés : environ 21 unités de diamètre.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47609;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47609, 7290031, -0.60, -10.44, -10.25, 2.80, 10.54, 10.60, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000508 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000508, 1829768651, 47609, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 105;
