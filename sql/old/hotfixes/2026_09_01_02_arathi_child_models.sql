-- ---------------------------------------------------------------------------------------------
-- Human child NPCs get the Arathi child models.
--
-- First attempt redirected three display records picked by NPC name; that was far too narrow and
-- lost their sounds. The right lever is the model: CreatureModelData 79 and 2972 hold
-- creature/humanmalekid, 80 holds creature/humanfemalekid, and **30 display records** share
-- them. Swapping the FileDataID on those three records moves every one of them at once, and
-- every field beside the file is copied back from the client's own record, so scale, collision,
-- geo box, flags and sounds are preserved.
--
-- The earlier display overrides are dropped below, along with the two model records they used.
--
-- TableHash 2554057490 is CreatureModelData, 1080191199 is CreatureDisplayInfo.
-- ---------------------------------------------------------------------------------------------

DELETE FROM `creature_model_data` WHERE `ID` IN (79, 80, 2972, 20000, 20001);
INSERT INTO `creature_model_data` (`ID`, `ModelScale`, `FootprintTextureLength`, `FootprintTextureWidth`, `FootprintParticleScale`, `CollisionWidth`, `CollisionHeight`, `MountHeight`, `GeoBox1`, `GeoBox2`, `GeoBox3`, `GeoBox4`, `GeoBox5`, `GeoBox6`, `WorldEffectScale`, `AttachedEffectScale`, `MissileCollisionRadius`, `MissileCollisionPush`, `MissileCollisionRaise`, `OverrideLootEffectScale`, `OverrideNameScale`, `OverrideSelectionRadius`, `TamedPetBaseScale`, `HoverHeight`, `Flags`, `FileDataID`, `SizeClass`, `BloodID`, `FootprintTextureID`, `FoleyMaterialID`, `FootstepCameraEffectID`, `DeathThudCameraEffectID`, `SoundID`, `CreatureGeosetDataID`, `VerifiedBuild`) VALUES
(79, 1, 10, 6, 1, 0.611111, 2.03128, 0, -0.169948, -0.254709, 0.007144, 0.212211, 0.25633, 1.30131, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 5763562, 1, 1, 1, 0, 0, 0, 79, 0, 26972),
(80, 1, 18, 12, 1, 0.611111, 2.03128, 0, -0.15346, -0.213333, -0.00407868, 0.096432, 0.209517, 1.15461, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 5763560, 1, 1, 4, 0, 0, 0, 80, 0, 26972),
(2972, 1, 18, 12, 1, 0.611111, 2.03128, 0, -0.169948, -0.254709, 0.007144, 0.212211, 0.25633, 1.30131, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 64, 5763562, 0, 3, 4, 0, 0, 0, 2853, 0, 26972);

-- The three displays go back to what the client ships: dropping both the rows and their hotfix
-- entries, then raising the cache version, makes the client fall back to its own records.
DELETE FROM `creature_display_info` WHERE `ID` IN (221, 262, 338);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000321 AND 9000325;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000321, 2554057490,   79, 0, 0),
(9000322, 2554057490,   80, 0, 0),
(9000323, 2554057490, 2972, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 27;
