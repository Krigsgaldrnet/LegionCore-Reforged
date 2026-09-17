-- The Confluence's area moves from 15010 to 9530.
--
-- `AreaTable.db2` stops at 9531 in 7.3.5, so 15010 was above the file's maximum: the record could
-- never reach the client, whatever the hotfix said. That is why the zone had no ambience and no
-- music - the client had no area record to hang them on, and the terrain pointed at a number it
-- could not resolve.
--
-- 9530 is free in the native file and below the maximum, which is the rule for every record created
-- by hand. The terrain's MCNK headers are rewritten to match, along with the spawns' zone and area
-- columns.
UPDATE `area_table` SET `ID` = 9530 WHERE `ID` = 15010;
UPDATE `map` SET `AreaTableID` = 9530 WHERE `ID` = 2678;
UPDATE `world_map_area` SET `AreaID` = 9530 WHERE `MapID` = 2678;
UPDATE `hotfix_data` SET `RecordID` = 9530 WHERE `Id` = 9000482;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 146;
