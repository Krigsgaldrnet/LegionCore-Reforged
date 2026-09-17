-- ==========================================================================================
-- Azerite Rush - fog that follows altitude
--
-- A single fog for the whole zone could not win: dense enough to hide the map edges seen from
-- the airship, it also swallowed the azerite nodes and the enemies at ground level.
--
-- SMSG_OVERRIDE_LIGHT is sent per player, so the fog can follow each one: dense above
-- FogAltitude, the map's own lighting below it. FogAltitudeMargin is the gap between the two
-- thresholds - without it a player hovering at the boundary would see the sky flicker.
--
-- The airship deck sits near Z 200 and the basin runs from -110 to +20, so 120 puts the change
-- well clear of both.
-- ==========================================================================================

ALTER TABLE `battleground_azerite_rush_map`
  ADD COLUMN `FogAltitude`       FLOAT NOT NULL DEFAULT 0  COMMENT 'Z above which the dense light is sent, 0 = one light for the whole zone' AFTER `WeatherIntensity`,
  ADD COLUMN `FogAltitudeMargin` FLOAT NOT NULL DEFAULT 30 COMMENT 'gap below FogAltitude before the fog is dropped again' AFTER `FogAltitude`;

UPDATE `battleground_azerite_rush_map`
SET `FogAltitude` = 120,
    `FogAltitudeMargin` = 30,
    `OverrideLightID` = 7321,
    `LightFadeMs` = 1500
WHERE `MapID` = 529;
