-- ==========================================================================================
-- Azerite Rush - point the mode at the new ground light
--
-- Below FogAltitude the mode used to hand the map's own lighting back. It now sends light 9301
-- instead: Arathi's sky with distant fog and the same skybox as the airship light, so crossing
-- the altitude changes the fog and nothing else.
--
-- 0 restores the previous behaviour, the map's own lighting untouched.
-- ==========================================================================================

ALTER TABLE `battleground_azerite_rush_map`
  ADD COLUMN `GroundLightID` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'light sent below FogAltitude, 0 = the map default' AFTER `FogAltitudeMargin`;

UPDATE `battleground_azerite_rush_map` SET `GroundLightID` = 9301 WHERE `MapID` = 529;
