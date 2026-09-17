-- Zone ambience for the Confluence - the background tone, not the music.
--
-- The path is `AreaTable.AmbienceID` -> `SoundAmbience` (one kit for day, one for night; a single
-- tone uses the same for both) -> `SoundKit` -> `SoundKitEntry`. Conventions read from the 689 kits
-- native ambiences use: SoundType 50, Flags 512 (loop), MinDistance 8, cutoff 45.
--
-- The file is the Dawn of the Infinite timeways zone tone, served by CASCHost under 5207989.
DELETE FROM `sound_kit` WHERE `ID` = 98324;
INSERT INTO `sound_kit`
 (`ID`, `VolumeFloat`, `MinDistance`, `DistanceCutoff`, `Flags`, `SoundEntriesAdvancedID`,
  `SoundType`, `DialogType`, `EAXDef`, `VolumeVariationPlus`, `VolumeVariationMinus`,
  `PitchVariationPlus`, `PitchVariationMinus`, `PitchAdjust`, `BusOverwriteID`, `MaxInstances`,
  `VerifiedBuild`) VALUES
 (98324, 1, 8, 45, 512, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 1, 26972);

DELETE FROM `sound_kit_entry` WHERE `ID` = 252955;
INSERT INTO `sound_kit_entry` (`ID`, `SoundKitID`, `FileDataID`, `Frequency`, `Volume`, `VerifiedBuild`) VALUES
 (252955, 98324, 5207989, 1, 1, 26972);

DELETE FROM `sound_ambience` WHERE `ID` = 1645;
INSERT INTO `sound_ambience` (`ID`, `Flags`, `SoundFilterID`, `FlavorSoundFilterID`,
  `AmbienceID1`, `AmbienceID2`, `VerifiedBuild`) VALUES
 (1645, 0, 0, 0, 98324, 98324, 26972);

UPDATE `area_table` SET `AmbienceID` = 1645 WHERE `ID` = 15010;

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000617 AND 9000619;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000617,  908293937, 98324, 0, 0),    -- SoundKit
 (9000618, 3266400455, 252955, 0, 0),   -- SoundKitEntry
 (9000619,  905567832, 1645, 0, 0);     -- SoundAmbience
-- AreaTable 15010 already has its own hotfix_data row (9000482).

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 144;
