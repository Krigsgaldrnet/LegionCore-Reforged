-- Trois variantes du portail du Vide, qui ne different que par les sous-maillages conserves.
--
-- Un affichage de gameobject ne designe qu'un seul M2, donc il faut trois copies du modele. Chacune
-- porte son propre SFID pointant sur ses propres peaux : sans cela les trois partageraient les memes
-- et la distinction disparaitrait.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47605, 47606);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47605, 8004145, -1.08, -6.22, -0.19, 5.07, 6.86, 11.99, 1, 1, 0, 26972),
 (47606, 8004144, -1.08, -6.22, -0.19, 5.07, 6.86, 11.99, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000495, 9000496) AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000495, 1829768651, 47605, 0, 0),
 (9000496, 1829768651, 47606, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 99;
