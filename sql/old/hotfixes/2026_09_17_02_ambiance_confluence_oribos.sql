-- Zone ambience of the Confluence moves to the Oribos tone.
--
-- Only the file behind the kit changes: AreaTable 2678 -> SoundAmbience 1645 -> SoundKit 98320
-- stays as it is, so the loop flag and the distance settings are kept.
--
-- 3571655 is the file's own id in the modern client, and it is free in 7.3.5: the listfile stops
-- well below it. Served by CASCHost under sound\ambience\zoneambience\amb_oribos_3571655.ogg.
UPDATE `sound_kit_entry` SET `FileDataID` = 3571655 WHERE `ID` = 252955;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 155;
