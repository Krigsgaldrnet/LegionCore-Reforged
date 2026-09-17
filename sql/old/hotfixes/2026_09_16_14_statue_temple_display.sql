-- Statue du temple de Bastion, rétroportée de la 12.1. Un M2 : il garde l'identifiant de fichier
-- réservé à l'import.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47640;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47640, 2904082, -5.68, -22.48, -8.06, 17.25, 22.07, 34.15, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000549;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000549, 1829768651, 47640, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 125;
