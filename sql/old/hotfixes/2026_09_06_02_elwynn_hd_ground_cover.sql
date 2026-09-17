-- ==========================================================================================
-- HD ground cover for Elwynn, scoped to Elwynn
--
-- The grass underfoot is not painted, it is sown. A terrain layer (`MCLY`) carries an effectId
-- pointing at GroundEffectTexture, which names four GroundEffectDoodad models, their weights and a
-- density; the client scatters those around the player. Elwynn's lawn is eleven models in
-- `world/nodxt/detail/`, each **eight vertices** - two crossed quads on a 256x256 atlas that
-- Blizzard never redrew, identical from 7.3.5 to 12.1.
--
-- Serving new bytes under those names would have been the short route, and the wrong one: elwgra03
-- alone is referenced by **163** GroundEffectTexture records across the old world, elwgra01 by 87.
-- One file swap would have resized and recoloured the ground cover of twenty zones - the same trap
-- that had to be undone on the Arathi river rocks.
--
-- So the models are left alone and the *link* is rewritten instead. Six new doodad records point at
-- the housing plants of patch 12.1, each baked to a size inside the range the old tufts occupied
-- (0.29 to 1.59 tall, 0.36 to 1.13 wide), and only the four ground effects that belong to Elwynn's
-- own textures are repointed at them:
--
--   505  ElwynnGrassBase   1406 layers      7828  ElwynnGrassBase    542 layers
--   507  ElwynnFlowerBase   899 layers      1106  ElwynnDirtBase2   1985 layers
--
-- Effect 512 is deliberately untouched: it sits on AeriePeaksScrubBrushBase and changing it would
-- repaint Aerie Peaks. In 1106 the fourth slot keeps doodad 36, a Duskwood model, for variety - it
-- is referenced, not modified.
--
-- These plants carry real geometry (17 to 707 vertices against 8), which is the point: the old
-- tufts read as pixelated up close. Density is a client-side slider, so the cost is adjustable by
-- whoever pays it.
--
-- TableHash 2777963210 is GroundEffectDoodad, 2164840845 is GroundEffectTexture.
-- ==========================================================================================

DELETE FROM `ground_effect_doodad` WHERE `ID` BETWEEN 60000 AND 60005;
INSERT INTO `ground_effect_doodad` (`ID`, `Animscale`, `PushScale`, `Flags`, `ModelFileID`, `VerifiedBuild`) VALUES
(60000, 1, 1, 0, 8000001, 26972),   -- grass_small   0.48 x 0.44 x 0.54
(60001, 1, 1, 0, 8000002, 26972),   -- grass_med     0.83 x 0.75 x 0.94
(60002, 1, 1, 0, 8000003, 26972),   -- grass_clump   1.27 x 1.13 x 0.94
(60003, 1, 1, 0, 8000004, 26972),   -- grass_wide    1.09 x 1.48 x 0.67
(60004, 1, 1, 0, 8000005, 26972),   -- flower_low    0.75 x 0.60 x 0.81
(60005, 1, 1, 0, 8000006, 26972);   -- flower_tall   1.09 x 0.87 x 1.18

DELETE FROM `ground_effect_texture` WHERE `ID` IN (505, 507, 1106, 7828);
INSERT INTO `ground_effect_texture`
  (`ID`, `DoodadID1`, `DoodadID2`, `DoodadID3`, `DoodadID4`,
   `DoodadWeight1`, `DoodadWeight2`, `DoodadWeight3`, `DoodadWeight4`, `Sound`, `Density`, `VerifiedBuild`) VALUES
( 505, 60001, 60002, 60003, 60000, 1, 1, 1, 1, 5, 8, 26972),
( 507, 60004, 60005, 60004, 60001, 1, 1, 1, 1, 5, 8, 26972),
(1106, 60000, 60000, 60001,    36, 1, 1, 1, 1, 0, 6, 26972),
(7828, 60000, 60001, 60002, 60001, 1, 1, 1, 1, 5, 8, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000350 AND 9000359;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000350, 2777963210, 60000, 0, 0),
(9000351, 2777963210, 60001, 0, 0),
(9000352, 2777963210, 60002, 0, 0),
(9000353, 2777963210, 60003, 0, 0),
(9000354, 2777963210, 60004, 0, 0),
(9000355, 2777963210, 60005, 0, 0),
(9000356, 2164840845,   505, 0, 0),
(9000357, 2164840845,   507, 0, 0),
(9000358, 2164840845,  1106, 0, 0),
(9000359, 2164840845,  7828, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 34;
