-- ==========================================================================================
-- Azerite Rush - stop the ground light from competing with Arathi Basin's own
--
-- Light 9301 was declared at the origin with no falloff on map 529, which is exactly what makes
-- a light global for a map. Map 529 then had two globals - 326 and ours - and nothing says which
-- one a client picks. A player in the ordinary Arathi Basin could have inherited our sky, which
-- is precisely the kind of leak the mode was built to avoid.
--
-- It never needed to be global: SMSG_OVERRIDE_LIGHT replaces one light by another by id, and
-- ignores what map the replacement is attached to. Light 7321, used by the airships, lives on
-- map 1468 and works here without trouble.
--
-- The record is therefore pushed far outside any ground with a falloff of a couple of yards: it
-- can never be selected by proximity, only named explicitly by the override.
-- ==========================================================================================

UPDATE `light`
SET `GameCoordsX` = -20000, `GameCoordsY` = -20000, `GameCoordsZ` = 0,
    `GameFalloffStart` = 1, `GameFalloffEnd` = 2
WHERE `ID` = 9301;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 12;
