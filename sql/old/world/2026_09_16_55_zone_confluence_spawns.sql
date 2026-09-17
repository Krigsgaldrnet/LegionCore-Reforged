-- Follows the area move from 15010 to 9530: the spawns carried the old number in their zone and
-- area columns.
UPDATE `gameobject` SET `zoneId` = 9530, `areaId` = 9530 WHERE `map` = 2678 AND `zoneId` = 15010;
UPDATE `creature` SET `zoneId` = 9530, `areaId` = 9530 WHERE `map` = 2678 AND `zoneId` = 15010;
