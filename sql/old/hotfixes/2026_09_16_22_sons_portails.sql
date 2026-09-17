-- Sons des portails de la Confluence, rapatriés de la 12.1.
--
-- Deux ensembles : la boucle du portail, qui porte les trois échantillons de la porte temporelle —
-- le client en tire un au sort à chaque lecture, c'est le rôle des entrées multiples d'un même
-- ensemble — et le coup unique de l'effet de téléportation.
--
-- Les identifiants restent sous le maximum déclaré par chaque fichier DB2 : SoundKit s'arrête à
-- 98 324 et SoundKitEntry à 252 958. Au-dessus, le serveur ignore l'enregistrement et le client
-- tombe.
DELETE FROM `sound_kit` WHERE `ID` IN (98323, 98322);
INSERT INTO `sound_kit`
 (`ID`, `VolumeFloat`, `MinDistance`, `DistanceCutoff`, `Flags`, `SoundEntriesAdvancedID`,
  `SoundType`, `DialogType`, `EAXDef`, `VolumeVariationPlus`, `VolumeVariationMinus`,
  `PitchVariationPlus`, `PitchVariationMinus`, `PitchAdjust`, `BusOverwriteID`, `MaxInstances`,
  `VerifiedBuild`) VALUES
 (98323, 1, 8, 60, 1, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 1, 26972),
 (98322, 1, 0, 80, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 1, 26972);

DELETE FROM `sound_kit_entry` WHERE `ID` BETWEEN 252951 AND 252954;
INSERT INTO `sound_kit_entry` (`ID`, `SoundKitID`, `FileDataID`, `Frequency`, `Volume`, `VerifiedBuild`) VALUES
 (252954, 98323, 4558593, 1, 1, 26972),
 (252953, 98323, 4558595, 1, 1, 26972),
 (252952, 98323, 4558597, 1, 1, 26972),
 (252951, 98322, 4565285, 1, 1, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000569 AND 9000574;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000569,  908293937,  98323, 0, 0),
 (9000570,  908293937,  98322, 0, 0),
 (9000571, 3266400455, 252954, 0, 0),
 (9000572, 3266400455, 252953, 0, 0),
 (9000573, 3266400455, 252952, 0, 0),
 (9000574, 3266400455, 252951, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 134;
