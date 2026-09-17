-- ==========================================================================================
-- Azerite Rush - zone atmosphere
--
-- A map built to be walked on shows its own edges once players are hundreds of yards above it.
-- The fix is the zone lighting: Light carries the fog distance, and Map::SetZoneOverrideLight
-- swaps one Light record for another without touching any client data.
--
-- OverrideLightID 0 leaves the map's own lighting alone. Find a value with `.debug lights 1803`
-- (Seething Shore, the battleground Blizzard built for the same problem) and try it on the spot
-- with `.debug light <id>`.
--
-- ZoneID 0 makes the core resolve the zone from the first pool node.
-- WeatherState 1 is fog; 0 disables the weather override.
-- ==========================================================================================

ALTER TABLE `battleground_azerite_rush_map`
  ADD COLUMN `ZoneID`           INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = resolved from the first pool node' AFTER `FallGuardZ`,
  ADD COLUMN `OverrideLightID`  INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Light.db2 record forced on the zone, 0 = map default' AFTER `ZoneID`,
  ADD COLUMN `LightFadeMs`      INT UNSIGNED NOT NULL DEFAULT 0 AFTER `OverrideLightID`,
  ADD COLUMN `WeatherState`     INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 fine, 1 fog' AFTER `LightFadeMs`,
  ADD COLUMN `WeatherIntensity` FLOAT        NOT NULL DEFAULT 0 AFTER `WeatherState`;
