-- Le portail vers la Confluence reprend l'effet des Voies du temps, mais il doit rester face à la
-- caméra alors que le portail 2600050 doit garder son cap. Un même fichier ne peut pas faire les
-- deux : le drapeau de billboard est dans le modèle, pas dans le gameobject.
--
-- D'où une copie du M2 et de ses quatre skins, `..._camera`, dont l'os racine retrouve le billboard
-- sphérique. La copie ne duplique aucune texture : elle désigne les mêmes par leur nom.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47646;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47646, 8004171, -9.66, -13.61, -12.87, 8.69, 13.61, 12.61, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000557;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000557, 1829768651, 47646, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 130;
