-- Affichage du tendril du Vide (12vd_void_tendril37.wmo, FileDataID 8004044).
--
-- GameObjectDisplayInfo accepte un WMO aussi bien qu'un M2 - c'est ainsi que Blizzard affiche ses
-- batiments. C'est la seule façon de remplacer un décor interne de WMO par un WMO : un MODD ne peut
-- référencer qu'un M2, donc le char à vapeur est masqué dans le champ de bataille et le tendril
-- posé à sa place comme objet à part entière.
--
-- 47603 est libre et reste sous le max_id de 47692.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47603;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47603, 8004044, 0, 0, 0, 0, 0, 0, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000493 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000493, 1829768651, 47603, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 96;
