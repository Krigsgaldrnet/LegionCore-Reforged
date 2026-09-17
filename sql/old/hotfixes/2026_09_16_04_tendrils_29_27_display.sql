-- Deux tendrils du Vide de plus, rétroportés de la 12.1.
--
-- L'identifiant de l'affichage est celui que CASCHost a réservé au fichier, lu dans root_entries
-- après reconstruction — jamais celui du listfile : une racine de WMO est toujours réécrite par le
-- convertisseur, donc toujours déposée sous un identifiant neuf de la plage 8004xxx.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47625, 47626);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47625, 8004156, -5.09, -16.37, -15.30, 6.10, 14.76, 49.34, 1, 1, 0, 26972),
 (47626, 8004155, -7.56, -36.33, -18.09, 10.91, 36.33, 44.52, 1, 1, 0, 26972);

DELETE FROM `destructible_model_data` WHERE `ID` IN (233, 234);
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (233, 47625, 1, 26972),
 (234, 47626, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000527 AND 9000530;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000527, 1829768651, 47625, 0, 0),
 (9000528, 2054439517, 233, 0, 0),
 (9000529, 1829768651, 47626, 0, 0),
 (9000530, 2054439517, 234, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 115;
