-- Cinq décors de Bastion de plus, tous des M2 : ils gardent l'identifiant de fichier réservé à
-- l'import, contrairement à un WMO dont la racine est réécrite.
DELETE FROM `gameobject_display_info` WHERE `ID` BETWEEN 47635 AND 47639;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47635, 3196754,   -6.56,   -6.26,   -5.02,    7.48,    6.26,   12.43, 1, 1, 0, 26972),
 (47636, 3256418,  -18.21,  -20.59,    0.00,   19.63,   23.46,   29.35, 1, 1, 0, 26972),
 (47637, 3288244, -110.62, -137.81, -182.44,  105.97,  107.16,  631.61, 1, 1, 0, 26972),
 (47638, 3567955,    4.01,   -3.48,   -3.01,   36.86,    6.53,    2.59, 1, 1, 0, 26972),
 (47639, 3605396,   -4.35,   -4.35,   -3.55,    4.35,    4.35,   24.80, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000544 AND 9000548;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000544, 1829768651, 47635, 0, 0),
 (9000545, 1829768651, 47636, 0, 0),
 (9000546, 1829768651, 47637, 0, 0),
 (9000547, 1829768651, 47638, 0, 0),
 (9000548, 1829768651, 47639, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 122;
