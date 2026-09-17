-- Four records created today sat on top of native ones, and a hotfix that lands on an existing id
-- replaces it rather than adding to it.
--
-- The cause was a bad reading of the DB2 files: `SoundKit` and `SoundEmitters` keep their id inside
-- the record instead of in a separate id list, so a scan that only reads that list finds it empty
-- and reports every number as free. The Confluence's ambience had taken SoundKit 98324, a native
-- dialogue kit, which is the voice heard looping in the zone.
--
-- Ids below are verified against the ids actually present in the files, id list and copy table.

-- Ambience kit 98324 -> 98320, and the native record is handed back by dropping our row.
UPDATE `sound_kit` SET `ID` = 98320 WHERE `ID` = 98324;
UPDATE `sound_kit_entry` SET `SoundKitID` = 98320 WHERE `SoundKitID` = 98324;
UPDATE `sound_ambience` SET `AmbienceID1` = 98320, `AmbienceID2` = 98320 WHERE `ID` = 1645;
UPDATE `hotfix_data` SET `RecordID` = 98320 WHERE `TableHash` = 908293937 AND `RecordID` = 98324;

-- The three portal emitters sat on native ones as well.
UPDATE `sound_emitters` SET `ID` = 11616 WHERE `ID` = 11623;
UPDATE `sound_emitters` SET `ID` = 11615 WHERE `ID` = 11622;
UPDATE `sound_emitters` SET `ID` = 11614 WHERE `ID` = 11621;
UPDATE `hotfix_data` SET `RecordID` = 11616 WHERE `TableHash` = 3325606100 AND `RecordID` = 11623;
UPDATE `hotfix_data` SET `RecordID` = 11615 WHERE `TableHash` = 3325606100 AND `RecordID` = 11622;
UPDATE `hotfix_data` SET `RecordID` = 11614 WHERE `TableHash` = 3325606100 AND `RecordID` = 11621;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 148;
