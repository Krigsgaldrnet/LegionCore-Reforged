-- ==========================================================================================
-- Stormwind back to its own sky
--
-- Light 9302 is pushed far outside any ground with a two yard falloff, so it can no longer be
-- selected by proximity and the city falls back to light 1, the global light of the Eastern
-- Kingdoms, exactly as before any of this.
--
-- Moved rather than deleted on purpose: withdrawing records with Deleted is what confused the
-- client earlier tonight, and there is no reason to reach for it when a coordinate does the job.
--
-- What was learnt and is worth keeping: a Light holds eight LightParams slots, one per weather
-- state, and the client switches between them as the weather changes. Azsuna's cloud banks are
-- most likely in a slot other than clear, which is the only one that was ever copied here. That
-- is where to resume if the idea comes back.
--
-- The battleground is untouched: it uses lights 7321 and 9301, neither of which is involved.
-- Records left behind by the attempts - LightParams 3702 and 3703, LightData 900110 onwards -
-- stay in the database, unreferenced and inert. Say the word and they get cleaned out.
-- ==========================================================================================

UPDATE `light`
SET `GameCoordsX` = -20000, `GameCoordsY` = -20000, `GameCoordsZ` = 0,
    `GameFalloffStart` = 1, `GameFalloffEnd` = 2
WHERE `ID` = 9302;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 17;
