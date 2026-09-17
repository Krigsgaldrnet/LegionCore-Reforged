-- Affichage du portail du Vide (12vd_void_ritual_summoningportal02, FileDataID 7960828).
--
-- 47602 est libre dans GameObjectDisplayInfo.db2 et reste sous son max_id de 47692 : au-dessus, le
-- serveur laisse tomber l'enregistrement. GeoBox est la boîte englobante lue dans l'en-tête MD20 du
-- modèle - c'est elle qui décide où un clic atterrit, donc une valeur fausse rend l'objet
-- incliquable.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47602;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47602, 7960828, -1.08, -6.22, -0.19, 5.07, 6.86, 11.99, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000492 AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000492, 1829768651, 47602, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 95;
