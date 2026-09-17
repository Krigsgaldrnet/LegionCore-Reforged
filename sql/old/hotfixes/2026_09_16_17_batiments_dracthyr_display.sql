-- Deux bâtiments dracthyr, rétroportés de la 12.1. Les identifiants de fichier sont ceux que
-- CASCHost leur a attribués, relus dans `root_entries` après reconstruction.
--
-- 195 et 194 sont libres dans la plage 25-241 que le fichier DB2 déclare.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47643, 47644);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47643, 8001623, -32.47, -31.78, -0.34, 37.95, 31.79, 48.04, 1, 1, 0, 26972),
 (47644, 8002008, -19.27, -27.48, -1.05, 19.27, 22.05,  8.51, 1, 1, 0, 26972);

DELETE FROM `destructible_model_data` WHERE `ID` IN (195, 194);
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (195, 47643, 1, 26972),
 (194, 47644, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000552 AND 9000555;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000552, 1829768651, 47643, 0, 0),
 (9000553, 2054439517,   195, 0, 0),
 (9000554, 1829768651, 47644, 0, 0),
 (9000555, 2054439517,   194, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 128;
