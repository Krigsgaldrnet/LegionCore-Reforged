-- Premiers modèles de Bastion, rétroportés de la 12.1 : une cloche de la Valkyr en objet de carte,
-- deux massifs de fleurs flottantes et un arbre-cage en M2.
--
-- La cloche est un WMO : son identifiant de fichier est celui que CASCHost lui a réservé, relu dans
-- `root_entries` après reconstruction. Les trois M2 gardent le leur, réservé à l'import.
--
-- 196 est libre dans la plage 25-241 que le fichier DB2 déclare.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47631, 47632, 47633, 47634);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47631, 8004164, -27.10, -27.10,  0.07, 27.10, 27.10, 29.46, 1, 1, 0, 26972),
 (47632, 3170877,  -5.79,  -1.68, -0.86,  6.73,  4.14,  4.99, 1, 1, 0, 26972),
 (47633, 3170878, -12.84,  -1.55, -2.60,  9.19, 12.19,  7.10, 1, 1, 0, 26972),
 (47634, 2741653, -18.63, -23.75,  1.91, 16.73, 23.75, 33.25, 1, 1, 0, 26972);

DELETE FROM `destructible_model_data` WHERE `ID` = 196;
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (196, 47631, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000539 AND 9000543;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000539, 1829768651, 47631, 0, 0),
 (9000540, 2054439517,   196, 0, 0),
 (9000541, 1829768651, 47632, 0, 0),
 (9000542, 1829768651, 47633, 0, 0),
 (9000543, 1829768651, 47634, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 119;
