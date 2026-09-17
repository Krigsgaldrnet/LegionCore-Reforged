-- Un tendril du Vide de plus, rétroporté de la 12.1 et réduit à 60 % dans le fichier : la taille
-- du gameobject n'atteint pas un objet de carte.
--
-- 197 est libre dans la plage 25-241 que le fichier DB2 déclare ; le bloc 225-240 est plein.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47630;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47630, 8004160, -10.63, -20.22, -9.12, 10.63, 25.82, 68.79, 1, 1, 0, 26972);

DELETE FROM `destructible_model_data` WHERE `ID` = 197;
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (197, 47630, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000537 AND 9000538;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000537, 1829768651, 47630, 0, 0),
 (9000538, 2054439517,   197, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 118;
