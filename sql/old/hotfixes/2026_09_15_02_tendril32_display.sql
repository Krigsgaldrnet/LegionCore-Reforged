-- Affichage du tendril 32 du Vide (12vd_void_tendril32.wmo, FileDataID 8004045), qui remplace
-- l'Ashbringer planté sur la plateforme du champ de bataille.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47604;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47604, 8004045, 0, 0, 0, 0, 0, 0, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000494 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000494, 1829768651, 47604, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 97;
