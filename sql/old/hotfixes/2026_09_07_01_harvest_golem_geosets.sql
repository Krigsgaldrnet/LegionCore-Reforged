-- ==========================================================================================
-- Give the harvest golem back the right silhouette
--
-- The retro-ported mesh draws every geoset it owns unless the display picks - and it owns several:
-- a hat, a diving helmet, a sickle, a scarf with claws, and sacks in five colours on one atlas.
-- Left unpicked, the client shows the group defaults, which is why the Harvest Watcher came out
-- green when its record asks for grey.
--
-- The choice is not invented. The same display identifiers exist in the build the mesh comes from,
-- and Blizzard's own CreatureDisplayInfoGeosetData says which geoset each one wears there. That
-- table does not exist in 7.3.5; the same choice travels here packed four bits per group in
-- CreatureDisplayInfo, which the core still calls DissolveEffectID.
--
--   display 367 Harvest Golem     groups 0=1 1=1        -> 17
--   display 378 Harvest Watcher   groups 0=1 1=1 2=3    -> 785
--   display 514 Rusty Golem       groups 0=1 1=1        -> 17
--
-- And the field is only read when the model declares one, exactly as with the riding horses:
-- CreatureModelData 71 carried zero. 402 is what the same model is declared with in its own build.
--
-- Three displays (35343, 36410, 41886) have no geoset record there either and are left alone.
--
-- TableHash 2137612197 is CreatureModelData, 4030871717 is CreatureDisplayInfo.
-- ==========================================================================================

DELETE FROM `creature_model_data` WHERE `ID` = 71;
INSERT INTO `creature_model_data` (`ID`, `ModelScale`, `FootprintTextureLength`, `FootprintTextureWidth`, `FootprintParticleScale`, `CollisionWidth`, `CollisionHeight`, `MountHeight`, `GeoBox1`, `GeoBox2`, `GeoBox3`, `GeoBox4`, `GeoBox5`, `GeoBox6`, `WorldEffectScale`, `AttachedEffectScale`, `MissileCollisionRadius`, `MissileCollisionPush`, `MissileCollisionRaise`, `OverrideLootEffectScale`, `OverrideNameScale`, `OverrideSelectionRadius`, `TamedPetBaseScale`, `HoverHeight`, `Flags`, `FileDataID`, `SizeClass`, `BloodID`, `FootprintTextureID`, `FoleyMaterialID`, `FootstepCameraEffectID`, `DeathThudCameraEffectID`, `SoundID`, `CreatureGeosetDataID`, `VerifiedBuild`) VALUES
(71, 1, 18, 12, 1, 0.61111110449, 2.03127789497, 0, -1.07358598709, -1.48199105263, -0.00585399987, 0.7284219861, 1.46034801006, 3.38175702095, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 8194, 124235, 1, 3, 1, 0, 0, 0, 71, 402, 26972);

DELETE FROM `creature_display_info` WHERE `ID` IN (71, 367, 378, 379, 514, 548, 1150, 17076, 22162, 23304, 35604, 35605, 36412, 57795, 57796, 57806, 57807, 57838, 57839);
INSERT INTO `creature_display_info` (`ID`, `CreatureModelScale`, `ModelID`, `NPCSoundID`, `SizeClass`, `Flags`, `Gender`, `ExtendedDisplayInfoID`, `PortraitTextureFileDataID`, `CreatureModelAlpha`, `SoundID`, `PlayerOverrideScale`, `PortraitCreatureDisplayInfoID`, `BloodID`, `ParticleColorID`, `DissolveEffectID`, `ObjectEffectPackageID`, `AnimReplacementSetID`, `UnarmedWeaponType`, `StateSpellVisualKitID`, `PetInstanceScale`, `MountPoofSpellVisualKitID`, `TextureVariationFileDataID1`, `TextureVariationFileDataID2`, `TextureVariationFileDataID3`, `VerifiedBuild`) VALUES
(71, 1, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(367, 0.85000002384, 71, 0, 255, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(378, 1.10000002384, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(379, 1.14999997616, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(514, 0.85000002384, 71, 0, 255, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(548, 1.29999995232, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124239, 124236, 0, 26972),
(1150, 0.40000000596, 71, 0, 1, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(17076, 1.75, 71, 0, 1, 0, 2, 0, 0, 255, 2221, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124239, 124236, 0, 26972),
(22162, 0.5, 71, 0, 1, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124239, 124236, 0, 26972),
(23304, 1, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124239, 124236, 0, 26972),
(35604, 1.5, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(35605, 1.5, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(36412, 1.5, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124239, 124236, 0, 26972),
(57795, 1.29999995232, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(57796, 0.69999998808, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(57806, 1.29999995232, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(57807, 1, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 17, 0, 0, -1, 0, 1, 0, 124241, 124238, 0, 26972),
(57838, 3, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972),
(57839, 2, 71, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 785, 0, 0, -1, 0, 1, 0, 124240, 124237, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000406 AND 9000425;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000406, 2137612197, 71, 0, 0),
(9000407, 4030871717, 71, 0, 0),
(9000408, 4030871717, 367, 0, 0),
(9000409, 4030871717, 378, 0, 0),
(9000410, 4030871717, 379, 0, 0),
(9000411, 4030871717, 514, 0, 0),
(9000412, 4030871717, 548, 0, 0),
(9000413, 4030871717, 1150, 0, 0),
(9000414, 4030871717, 17076, 0, 0),
(9000415, 4030871717, 22162, 0, 0),
(9000416, 4030871717, 23304, 0, 0),
(9000417, 4030871717, 35604, 0, 0),
(9000418, 4030871717, 35605, 0, 0),
(9000419, 4030871717, 36412, 0, 0),
(9000420, 4030871717, 57795, 0, 0),
(9000421, 4030871717, 57796, 0, 0),
(9000422, 4030871717, 57806, 0, 0),
(9000423, 4030871717, 57807, 0, 0),
(9000424, 4030871717, 57838, 0, 0),
(9000425, 4030871717, 57839, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 39;
