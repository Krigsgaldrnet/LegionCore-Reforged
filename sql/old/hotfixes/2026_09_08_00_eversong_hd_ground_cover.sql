-- ==========================================================================================
-- HD ground cover for Eversong Woods
--
-- Eversong's lawn is Elwynn's lawn. Of the 21 ground effects painted across Quel'Thalas, exactly
-- two hold nothing but Elwynn models - 21687 (3421 layers) and 97001 (447) - and both sit on
-- eversonggrass02, a texture of Eversong's own tileset. Repointing them carries the HD tufts into
-- Sylvepine and nowhere else.
--
--   elwgra01 -> 60000 grass_small     elwgra08 -> 60000 grass_small
--   elwgra02 -> 60002 grass_clump     elwflo03 -> 60004 flower_low
--
-- Same substitutions as the two Elwynn passes, so the two zones stay consistent. Weights, sound
-- and density are kept, so the composition of each effect is unchanged.
--
-- The rest of Quel'Thalas is deliberately left alone. The Ghostlands effects seed gst* models,
-- and the scattered ones seed dslbon* from Desolace and bstbra* from the Blasted Lands: green
-- Elwynn grass has no business in a blighted zone, and those models belong to other zones anyway.
--
-- TableHash 2164840845 is GroundEffectTexture.
-- ==========================================================================================

DELETE FROM `ground_effect_texture` WHERE `ID` IN (21687, 97001);

INSERT INTO `ground_effect_texture`
  (`ID`, `DoodadID1`, `DoodadID2`, `DoodadID3`, `DoodadID4`,
   `DoodadWeight1`, `DoodadWeight2`, `DoodadWeight3`, `DoodadWeight4`, `Sound`, `Density`, `VerifiedBuild`) VALUES
(21687, 60000, 60002, 60000, 60004, 1, 1, 1, 1, 5, 8, 26972),
(97001, 60000, 60002, 60000, 60004, 1, 1, 1, 1, 5, 8, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000426, 9000427);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000426, 2164840845, 21687, 0, 0),
(9000427, 2164840845, 97001, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 40;
