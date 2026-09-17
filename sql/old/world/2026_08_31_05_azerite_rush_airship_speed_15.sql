-- ==========================================================================================
-- Azerite Rush - airship speed raised to 15
--
-- 10 was still a slow drift around a 2140 yard ring, close to three and a half minutes a lap.
-- 15 brings it to roughly two and a half minutes.
-- ==========================================================================================

UPDATE `gameobject_template` SET `Data1` = 15 WHERE `entry` IN (900001, 900002);
