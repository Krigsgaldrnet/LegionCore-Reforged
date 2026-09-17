-- New zone music for the Confluence: Cinder Summit replaces Dawn of the Infinite.
--
-- Only the file changes; the kit, the ZoneMusic record and the area keep their numbers, so there is
-- nothing else to follow.
UPDATE `sound_kit_entry` SET `FileDataID` = 5483945 WHERE `ID` = 252950;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 150;
