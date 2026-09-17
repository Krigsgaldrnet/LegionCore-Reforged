-- The second helix kept disappearing because both spawns used entry 2600044: `LoadGameobjects`
-- deletes a spawn of the same entry standing within 0.71 yd of the previous one, and these two sit
-- at the exact same spot. Entry 2600054 is the twin created for that, so the pair is placed with
-- one of each.
--
-- State 0 is what plays the looping animation; `.gob add` writes 1.
SET @source := (SELECT guid FROM `gameobject` WHERE `id` = 2600044 LIMIT 1);
SET @neuf := (SELECT MAX(guid) + 1 FROM `gameobject`);

DELETE FROM `gameobject` WHERE `id` = 2600054;
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `phaseId`, `position_x`,
  `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`)
SELECT @neuf, 2600054, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `phaseId`, `position_x`,
  `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, 255, 0
FROM `gameobject` WHERE `guid` = @source;

UPDATE `gameobject` SET `state` = 0, `animprogress` = 255 WHERE `id` = 2600044;
