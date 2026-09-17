-- Effet de portail des Voies du temps, rétroporté de la 12.1. Un M2 : il garde l'identifiant de
-- fichier réservé à l'import.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47642;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47642, 5185046, -9.66, -13.61, -12.87, 8.69, 13.61, 12.61, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000551;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000551, 1829768651, 47642, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 127;
