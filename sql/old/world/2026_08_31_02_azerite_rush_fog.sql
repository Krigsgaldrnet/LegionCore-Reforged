-- ==========================================================================================
-- Azerite Rush - the fog that hides the map edges
--
-- Arathi Basin was built to be walked on, so its own edges come into view once players are on
-- an airship. Light 7321 (map 1468, FogEnd 40, density 13.1) is dense enough to cover them and
-- was picked in game over the alternatives; nothing had to be created, it is a record the client
-- already ships.
--
-- The core sends "replace A by B", where A is the map's global light. For map 529 that is 326,
-- so the swap has a real target. ZoneID is stated rather than derived, to keep it explicit.
-- ==========================================================================================

UPDATE `battleground_azerite_rush_map`
SET `ZoneID` = 3358,
    `OverrideLightID` = 7321,
    `LightFadeMs` = 2000
WHERE `MapID` = 529;
