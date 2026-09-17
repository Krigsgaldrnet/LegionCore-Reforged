-- ==========================================================================================
-- Azerite Rush - airship speed for the wide orbit
--
-- The ring around the basin is about 2140 yards around. At the borrowed speed of 4 a lap took
-- close to nine minutes, longer than many matches: the ships would have looked motionless.
-- 10 brings a lap down to roughly three and a half minutes, slow enough to read as a patrol.
--
-- Data1 is moveSpeed, Data2 accelRate.
-- ==========================================================================================

UPDATE `gameobject_template` SET `Data1` = 10 WHERE `entry` IN (900001, 900002);
