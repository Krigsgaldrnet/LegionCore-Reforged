-- Lustre de Bastion, rétroporté de la 12.1. Un M2 : il garde l'identifiant de fichier réservé à
-- l'import.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47641;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47641, 3023905, -9.41, -9.39, 3.39, 9.39, 9.41, 17.98, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000550;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000550, 1829768651, 47641, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 126;
