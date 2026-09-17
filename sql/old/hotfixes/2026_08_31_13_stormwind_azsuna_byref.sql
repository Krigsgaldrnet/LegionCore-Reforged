-- ==========================================================================================
-- Stormwind under Azsuna's palette, by reference instead of by copy
--
-- Two attempts at cloning LightData into a parameter set of our own both reached the client
-- broken: `.debug fogwhere` proved light 9302 was picked and the sky did change, but into a flat
-- haze rather than Azsuna's clouds. The rows are read correctly server side - LightParamID and
-- Time come back sane - so what fails is writing them back out, in a table whose relationship
-- column the hotfix serialisation apparently does not place where the client expects it.
--
-- None of that copying was necessary. A Light record holds no colour at all: it points at a
-- LightParams. Nothing says that set has to be ours. Light 9302 now points straight at 1806,
-- the parameters of the Broken Isles global light - a record the client has always had and knows
-- how to read.
--
-- No fabricated rows, no LightData hotfix, nothing to serialise. Stormwind gets Azsuna's palette
-- exactly as Azsuna renders it, cloud colours, density and HighlightSky included.
--
-- The records made by the earlier attempts stay behind, unreferenced and harmless.
-- ==========================================================================================

UPDATE `light`
SET `LightParamsID1` = 1806, `LightParamsID2` = 1806, `LightParamsID3` = 1806, `LightParamsID4` = 1806,
    `LightParamsID5` = 1806, `LightParamsID6` = 1806, `LightParamsID7` = 1806, `LightParamsID8` = 1806
WHERE `ID` = 9302;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 16;
