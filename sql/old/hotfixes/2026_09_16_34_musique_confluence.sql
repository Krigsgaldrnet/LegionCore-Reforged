-- Zone music for the Confluence, alongside the ambience tone added just before.
--
-- `AreaTable.ZoneMusic` -> `ZoneMusic` (one kit for day, one for night, plus the silence between
-- two plays) -> `SoundKit` -> `SoundKitEntry`. Conventions read from the 1537 kits native zone music
-- uses: SoundType 28, no flags, volume 0.8, and silences of 3 to 5 minutes.
--
-- Dawn of the Infinite, first movement, served by CASCHost under 5282291. The b, c and h movements
-- exist in the same folder and can be added as further entries on the same kit, which is what a
-- native zone does.
DELETE FROM `sound_kit` WHERE `ID` = 98321;
INSERT INTO `sound_kit`
 (`ID`, `VolumeFloat`, `MinDistance`, `DistanceCutoff`, `Flags`, `SoundEntriesAdvancedID`,
  `SoundType`, `DialogType`, `EAXDef`, `VolumeVariationPlus`, `VolumeVariationMinus`,
  `PitchVariationPlus`, `PitchVariationMinus`, `PitchAdjust`, `BusOverwriteID`, `MaxInstances`,
  `VerifiedBuild`) VALUES
 (98321, 0.8, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 1, 26972);

DELETE FROM `sound_kit_entry` WHERE `ID` = 252950;
INSERT INTO `sound_kit_entry` (`ID`, `SoundKitID`, `FileDataID`, `Frequency`, `Volume`, `VerifiedBuild`) VALUES
 (252950, 98321, 5282291, 1, 1, 26972);

DELETE FROM `zone_music` WHERE `ID` = 1912;
INSERT INTO `zone_music` (`ID`, `SetName`, `SilenceIntervalMin1`, `SilenceIntervalMin2`,
  `SilenceIntervalMax1`, `SilenceIntervalMax2`, `Sounds1`, `Sounds2`, `VerifiedBuild`) VALUES
 (1912, 'TemporalConfluence', 180000, 180000, 300000, 300000, 98321, 98321, 26972);

UPDATE `area_table` SET `ZoneMusic` = 1912 WHERE `ID` = 15010;

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000620 AND 9000622;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000620,  908293937, 98321, 0, 0),    -- SoundKit
 (9000621, 3266400455, 252950, 0, 0),   -- SoundKitEntry
 (9000622, 4071081280, 1912, 0, 0);     -- ZoneMusic

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 145;
