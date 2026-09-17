-- Le Cauchemar lucide (sort 247402) et le Coursierêve sauvage (sort 242875) gardent le modèle de
-- cheval d'origine.
--
-- Les deux montures partagent `creature/horse2/horse2.m2`, que CASCHost remplace par le nouveau
-- cheval - avec six de ses textures. Elles héritaient donc du remplacement. Une copie intacte du
-- modèle natif est servie sous `creature/horse2_lucid/`, avec les deux textures que leurs affichages
-- fournissent : celles-ci sont de type 11, c'est-à-dire données par CreatureDisplayInfo et non
-- nommées dans le modèle, donc les copier ne suffisait pas sans recréer l'affichage.
--
-- Chaque monture reçoit son propre CreatureModelData et son propre CreatureDisplayInfo, recopiés
-- des originaux champ par champ, seuls le fichier et la texture changeant. Les identifiants restent
-- sous les max_id de leurs fichiers : 10738 pour CreatureModelData, 83274 pour CreatureDisplayInfo.
DELETE FROM `creature_model_data` WHERE `ID` IN (10736,10737);
INSERT INTO `creature_model_data` (`ID`,`ModelScale`,`FootprintTextureLength`,`FootprintTextureWidth`,`FootprintParticleScale`,`CollisionWidth`,`CollisionHeight`,`MountHeight`,`GeoBox1`,`GeoBox2`,`GeoBox3`,`GeoBox4`,`GeoBox5`,`GeoBox6`,`WorldEffectScale`,`AttachedEffectScale`,`MissileCollisionRadius`,`MissileCollisionPush`,`MissileCollisionRaise`,`OverrideLootEffectScale`,`OverrideNameScale`,`OverrideSelectionRadius`,`TamedPetBaseScale`,`HoverHeight`,`Flags`,`FileDataID`,`SizeClass`,`BloodID`,`FootprintTextureID`,`FoleyMaterialID`,`FootstepCameraEffectID`,`DeathThudCameraEffectID`,`SoundID`,`CreatureGeosetDataID`,`VerifiedBuild`) VALUES
 (10737, 1, 15, 10, 1, 0.61111110449, 2.03127789497, 1.95104002953, -2.44328260422, -0.49295729399, -0.24652305245, 1.98013913631, 0.45539963245, 2.89381456375, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 4096, 8004147, 1, 1, 15, 0, 0, 0, 5518, 0, 26972),
 (10736, 1, 15, 10, 1, 0.61111110449, 2.03127789497, 1.95104002953, -2.44328260422, -0.49295729399, -0.24652305245, 1.98013913631, 0.45539963245, 2.89381456375, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 4096, 8004147, 1, 1, 3, 0, 0, 0, 5518, 0, 26972);

DELETE FROM `creature_display_info` WHERE `ID` IN (83272,83273);
INSERT INTO `creature_display_info` (`ID`,`CreatureModelScale`,`ModelID`,`NPCSoundID`,`SizeClass`,`Flags`,`Gender`,`ExtendedDisplayInfoID`,`PortraitTextureFileDataID`,`CreatureModelAlpha`,`SoundID`,`PlayerOverrideScale`,`PortraitCreatureDisplayInfoID`,`BloodID`,`ParticleColorID`,`DissolveEffectID`,`ObjectEffectPackageID`,`AnimReplacementSetID`,`UnarmedWeaponType`,`StateSpellVisualKitID`,`PetInstanceScale`,`MountPoofSpellVisualKitID`,`TextureVariationFileDataID1`,`TextureVariationFileDataID2`,`TextureVariationFileDataID3`,`VerifiedBuild`) VALUES
 (83273, 1, 10737, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 1, 0, 8004146, 0, 0, 26972),
 (83272, 1, 10736, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 1, 0, 8004148, 0, 0, 26972);

UPDATE `mount_x_display` SET `CreatureDisplayInfoID` = 83273 WHERE `ID` = 884;
UPDATE `mount_x_display` SET `CreatureDisplayInfoID` = 83272 WHERE `ID` = 861;

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000497 AND 9000502;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000497, 2137612197, 10736, 0, 0),
 (9000498, 2137612197, 10737, 0, 0),
 (9000499, 3218799089, 83272, 0, 0),
 (9000500, 3218799089, 83273, 0, 0),
 (9000501, 2030087241,   861, 0, 0),
 (9000502, 2030087241,   884, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 100;
