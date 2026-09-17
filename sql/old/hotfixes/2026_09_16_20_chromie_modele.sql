-- Nouveau modèle de Chromie, rétroporté de la 12.1.
--
-- Un modèle de créature demande deux enregistrements DB2 : `creature_model_data` pour le fichier et
-- ses volumes, `creature_display_info` pour l'apparence qui le désigne. Les identifiants restent
-- dans les plages que les fichiers déclarent — 1..10738 et 4..83274 — sans quoi le serveur les
-- ignore et le client tombe.
--
-- Les volumes viennent de la boîte de collision du modèle, pas de sa boîte englobante : celle-ci
-- couvre l'amplitude de la cinématique 1452 et va jusqu'à -17,49.
DELETE FROM `creature_model_data` WHERE `ID` = 10735;
INSERT INTO `creature_model_data`
 (`ID`, `ModelScale`, `FootprintTextureLength`, `FootprintTextureWidth`, `FootprintParticleScale`,
  `CollisionWidth`, `CollisionHeight`, `MountHeight`,
  `GeoBox1`, `GeoBox2`, `GeoBox3`, `GeoBox4`, `GeoBox5`, `GeoBox6`,
  `WorldEffectScale`, `AttachedEffectScale`, `MissileCollisionRadius`, `MissileCollisionPush`,
  `MissileCollisionRaise`, `OverrideLootEffectScale`, `OverrideNameScale`, `OverrideSelectionRadius`,
  `TamedPetBaseScale`, `HoverHeight`, `Flags`, `FileDataID`, `SizeClass`, `BloodID`,
  `FootprintTextureID`, `FoleyMaterialID`, `FootstepCameraEffectID`, `DeathThudCameraEffectID`,
  `SoundID`, `CreatureGeosetDataID`, `VerifiedBuild`) VALUES
 (10735, 1, 0, 0, 0, 0.31, 2.03, 0,
  -0.31, -0.31, 0.00, 0.31, 0.31, 2.03,
  1, 1, 0, 0, 0, 1, 1, 0,
  1, 1, 4096, 4639516, 1, 0,
  0, 0, 0, 0,
  0, 0, 26972);

DELETE FROM `creature_display_info` WHERE `ID` = 83273;
INSERT INTO `creature_display_info`
 (`ID`, `CreatureModelScale`, `ModelID`, `NPCSoundID`, `SizeClass`, `Flags`, `Gender`,
  `ExtendedDisplayInfoID`, `PortraitTextureFileDataID`, `CreatureModelAlpha`, `SoundID`,
  `PlayerOverrideScale`, `PortraitCreatureDisplayInfoID`, `BloodID`, `ParticleColorID`,
  `DissolveEffectID`, `ObjectEffectPackageID`, `AnimReplacementSetID`, `UnarmedWeaponType`,
  `StateSpellVisualKitID`, `PetInstanceScale`, `MountPoofSpellVisualKitID`,
  `TextureVariationFileDataID1`, `TextureVariationFileDataID2`, `TextureVariationFileDataID3`,
  `VerifiedBuild`) VALUES
 (83273, 1, 10735, 0, 1, 0, 1,
  0, 0, 255, 0,
  0, 0, 0, 0,
  0, 0, 0, -1,
  0, 1, 0,
  0, 0, 0,
  26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000558 AND 9000559;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000558, 2137612197, 10735, 0, 0),
 (9000559, 3218799089, 83273, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 131;
