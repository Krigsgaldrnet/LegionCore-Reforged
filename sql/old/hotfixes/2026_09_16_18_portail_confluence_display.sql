-- Portail temporel du Remix, rétroporté de la 12.1. Un M2 : il garde l'identifiant de fichier
-- réservé à l'import.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47645;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47645, 5935247, 0.53, -11.70, -7.46, 0.99, 11.70, 15.95, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000556;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000556, 1829768651, 47645, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 129;
