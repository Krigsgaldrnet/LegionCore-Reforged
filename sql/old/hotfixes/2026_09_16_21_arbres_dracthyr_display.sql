-- Neuf arbres et troncs de l'extérieur dracthyr, rétroportés de la 12.1. Des M2 : ils gardent
-- l'identifiant de fichier réservé à l'import.
DELETE FROM `gameobject_display_info` WHERE `ID` BETWEEN 47647 AND 47655;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47647, 4025193, -29.11, -42.91, -7.21, 33.04, 29.28, 52.26, 1, 1, 0, 26972),
 (47648, 4030628, -10.56, -16.28, -5.86, 9.14, 10.28, 30.96, 1, 1, 0, 26972),
 (47649, 4030629, -24.87, -6.73, -5.69, 4.55, 11.63, 17.00, 1, 1, 0, 26972),
 (47650, 4030630, -9.80, -16.05, -22.81, 24.32, 9.17, 1.87, 1, 1, 0, 26972),
 (47651, 4030634, -12.62, -12.29, -7.03, 21.23, 30.95, 60.47, 1, 1, 0, 26972),
 (47652, 4030635, -19.34, -15.06, -6.86, 24.29, 18.90, 41.92, 1, 1, 0, 26972),
 (47653, 4030631, -6.86, -6.90, -4.81, 3.63, 13.37, 47.36, 1, 1, 0, 26972),
 (47654, 4030632, -13.08, -9.87, -6.28, 7.81, 11.43, 32.16, 1, 1, 0, 26972),
 (47655, 4030633, -12.47, -4.50, -6.00, 18.05, 24.74, 46.61, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000560 AND 9000568;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000560, 1829768651, 47647, 0, 0),
 (9000561, 1829768651, 47648, 0, 0),
 (9000562, 1829768651, 47649, 0, 0),
 (9000563, 1829768651, 47650, 0, 0),
 (9000564, 1829768651, 47651, 0, 0),
 (9000565, 1829768651, 47652, 0, 0),
 (9000566, 1829768651, 47653, 0, 0),
 (9000567, 1829768651, 47654, 0, 0),
 (9000568, 1829768651, 47655, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 133;
