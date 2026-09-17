-- ==========================================================================================
-- The geoset choice needs the model to declare it
--
-- 2026_09_06_00 filled CreatureGeosetData on the eighteen riding-horse displays, the client
-- received the records - checked byte for byte inside Cache/ADB/frFR/DBCache.bin, geoset 0x51 and
-- tack texture 1793546 both present - and drew every saddle and banner anyway.
--
-- What was missing is on the other side of the link. A display's geoset field is only read when
-- its model declares one: `CreatureModelData.CreatureGeosetDataID`. Of the 3793 displays that
-- carry a geoset value in the 7.3.5 client, **not one** sits on a model whose CreatureGeosetDataID
-- is zero. Model 216 had zero.
--
-- The value is not invented: the same model, in the build the mesh comes from, is declared with
-- CreatureGeosetDataID 387. Legion's own records stop at 386, which is what a model added later
-- looks like.
--
-- Everything else in the row is the client's own record, FileDataID 125614 included - the new
-- mesh is served under that name, so it must not move.
--
-- TableHash 2137612197 is CreatureModelData.
-- ==========================================================================================

DELETE FROM `creature_model_data` WHERE `ID` = 216;
INSERT INTO `creature_model_data`
  (`ID`, `ModelScale`, `FootprintTextureLength`, `FootprintTextureWidth`, `FootprintParticleScale`,
   `CollisionWidth`, `CollisionHeight`, `MountHeight`, `GeoBox1`, `GeoBox2`, `GeoBox3`, `GeoBox4`,
   `GeoBox5`, `GeoBox6`, `WorldEffectScale`, `AttachedEffectScale`, `MissileCollisionRadius`,
   `MissileCollisionPush`, `MissileCollisionRaise`, `OverrideLootEffectScale`, `OverrideNameScale`,
   `OverrideSelectionRadius`, `TamedPetBaseScale`, `HoverHeight`, `Flags`, `FileDataID`, `SizeClass`,
   `BloodID`, `FootprintTextureID`, `FoleyMaterialID`, `FootstepCameraEffectID`,
   `DeathThudCameraEffectID`, `SoundID`, `CreatureGeosetDataID`, `VerifiedBuild`) VALUES
(216, 1, 18, 12, 1, 0.61111110449, 2.03127789497, 1.98562002182, -1.24379324913, -0.43474310637, -0.01819352992, 2.0046210289, 0.44348695874, 2.60213470459, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 4096, 125614, 1, 1, 6, 0, 0, 0, 65, 387, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000349;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000349, 2137612197, 216, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 33;
