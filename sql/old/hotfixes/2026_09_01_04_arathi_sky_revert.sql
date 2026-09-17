-- ---------------------------------------------------------------------------------------------
-- Drop the Arathi Basin light hotfix: it was the wrong lever.
--
-- Rewriting map 529's own lights 326 and 327 never reached the sky, and the reason is now clear.
-- What works on this server is SMSG_OVERRIDE_LIGHT, which names the replacement explicitly
-- instead of letting the client resolve a light by proximity from its own tables. Azerite Rush
-- has used it since 2026-08-31; the classic battleground now does the same, from
-- BattlegroundArathiBasin::SetupBattleground.
--
-- Restoring 326 also matters on its own: Map::SetZoneOverrideLight replaces the map's default
-- light, which is the one sitting at (0,0,0) - that is 326. Leaving it rewritten would have moved
-- the ground both modes start from.
--
-- Dropping the rows and their hotfix entries, then raising the cache version, sends the client
-- back to its own records.
-- ---------------------------------------------------------------------------------------------

DELETE FROM `light` WHERE `ID` IN (326, 327);
DELETE FROM `hotfix_data` WHERE `Id` IN (9000320, 9000326);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 29;
