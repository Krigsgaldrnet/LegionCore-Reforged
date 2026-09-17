-- Affichage de 12vd_void_structure04.wmo (FileDataID 8004078), qui remplace le bâtiment d'Alliance
-- de la plateforme du champ de bataille.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47607;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47607, 8004078, -53.94, -74.08, -3.45, 55.67, 74.14, 148.20, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000503 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000503, 1829768651, 47607, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 101;
