-- The Confluence's area takes the number of its own map: 2678.
--
-- It is free in the native file and well under the 9531 ceiling, which is the only hard constraint.
-- Matching the map id costs nothing and saves a lookup every time someone reads a spawn row or a
-- terrain header.
UPDATE `area_table` SET `ID` = 2678 WHERE `ID` = 9530;
UPDATE `map` SET `AreaTableID` = 2678 WHERE `ID` = 2678;
UPDATE `world_map_area` SET `AreaID` = 2678 WHERE `MapID` = 2678;
UPDATE `hotfix_data` SET `RecordID` = 2678 WHERE `Id` = 9000482;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 147;
