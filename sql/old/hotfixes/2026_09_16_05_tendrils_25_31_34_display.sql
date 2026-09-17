-- Trois tendrils du Vide de plus, rétroportés de la 12.1.
--
-- Les identifiants d'affichage sont ceux que CASCHost a réservés aux fichiers, relus dans
-- `root_entries` après reconstruction : une racine de WMO est toujours réécrite par le
-- convertisseur, donc toujours déposée sous un identifiant neuf de la plage 8004xxx.
--
-- Les enregistrements destructibles descendent sous le bloc 233-240 déjà pris : 231, 227 et 225
-- sont libres dans la plage 25-241 que le fichier DB2 déclare. Au-dessus de 241, le serveur ignore
-- l'enregistrement et le client tombe.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47627, 47628, 47629);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47627, 8004158, -10.43, -18.40, -38.74, 11.28, 25.70, 109.10, 1, 1, 0, 26972),
 (47628, 8004157,  -6.42,  -6.20,  -2.68,  4.86,  5.64,  14.86, 1, 1, 0, 26972),
 (47629, 8004159, -20.35, -59.61, -21.53, 20.35, 49.15, 122.08, 1, 1, 0, 26972);

DELETE FROM `destructible_model_data` WHERE `ID` IN (231, 227, 225);
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (231, 47627, 1, 26972),
 (227, 47628, 1, 26972),
 (225, 47629, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000531 AND 9000536;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000531, 1829768651, 47627, 0, 0),
 (9000532, 2054439517,   231, 0, 0),
 (9000533, 1829768651, 47628, 0, 0),
 (9000534, 2054439517,   227, 0, 0),
 (9000535, 1829768651, 47629, 0, 0),
 (9000536, 2054439517,   225, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 116;
