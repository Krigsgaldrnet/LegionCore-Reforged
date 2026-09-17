-- Follows the area renumbering to 2678.
UPDATE `gameobject` SET `zoneId` = 2678, `areaId` = 2678 WHERE `map` = 2678 AND `zoneId` = 9530;
UPDATE `creature` SET `zoneId` = 2678, `areaId` = 2678 WHERE `map` = 2678 AND `zoneId` = 9530;
