-- Affichage de 12fx_voidball01.m2 (FileDataID 7469761), une sphère du Vide rétroportée de la 12.1.
-- Boîte relevée sur les sommets réellement dessinés du modèle.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47608;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47608, 7469761, 0.05, -0.70, -0.70, 0.52, 0.69, 0.69, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000507 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000507, 1829768651, 47608, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 104;
