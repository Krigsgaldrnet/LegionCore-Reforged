-- ==========================================================================================
-- Eversong's ground cover moves from Elwynn's grass set to Elwynn's flower set.
--
-- The first pass gave effects 21687 and 97001 the grass composition, mapping each old model to the
-- HD tuft closest in size. In game the texture underneath is 12esw_flowers01, so plain grass reads
-- against it rather than with it. This uses the composition of Elwynn's own ElwynnFlowerBase
-- record, 507, which is the same one the flower texture carries there:
--
--   60004 flower_low, 60005 flower_tall, 60004 flower_low, 60001 grass_med
--
-- Two flowers to one grass, so the cover stays mixed rather than becoming a flowerbed. Sound and
-- density are unchanged.
--
-- TableHash 2164840845 is GroundEffectTexture. The hotfix_data rows already exist from the first
-- pass and are left alone - only the records they point at change.
-- ==========================================================================================

DELETE FROM `ground_effect_texture` WHERE `ID` IN (21687, 97001);

INSERT INTO `ground_effect_texture`
  (`ID`, `DoodadID1`, `DoodadID2`, `DoodadID3`, `DoodadID4`,
   `DoodadWeight1`, `DoodadWeight2`, `DoodadWeight3`, `DoodadWeight4`, `Sound`, `Density`, `VerifiedBuild`) VALUES
(21687, 60004, 60005, 60004, 60001, 1, 1, 1, 1, 5, 8, 26972),
(97001, 60004, 60005, 60004, 60001, 1, 1, 1, 1, 5, 8, 26972);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 42;
