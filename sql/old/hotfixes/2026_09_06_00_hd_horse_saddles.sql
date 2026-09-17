-- ==========================================================================================
-- Saddles for the HD horses
--
-- The eighteen displays built on creature/ridinghorse/ridinghorse.m2 now render the BfA model
-- horsemultisaddle, which does not carry a saddle the way the old one did. Its mesh holds three
-- interchangeable bodies (geosets 101-103), nine saddles (201-209) and two banners (301-302),
-- and the display record is what picks one of each. Ours picked none, so the client drew every
-- one of them at once, and masking the extra geosets inside the .skin files traded stacked
-- saddles for no saddle at all.
--
-- CreatureDisplayInfo carries the choice in one field. The column the core calls DissolveEffectID
-- is in truth CreatureGeosetData: four bits per geoset group, group N reading bits 4N..4N+3 and
-- selecting geoset (N+1)*100 + value. Checked against the CreatureDisplayInfoGeosetData table of
-- a later build, where the same displays are described row by row: 3791 of 3792 records agree.
--
--   0x51 = group 0 value 1, group 1 value 5  ->  body 101, saddle 205
--   0x73 = group 0 value 3, group 1 value 7  ->  body 103, saddle 207
--
-- The saddle mesh takes its texture from the model's second replaceable slot, which the display
-- fills through TextureVariationFileDataID2. Left at zero it renders black, which is what the
-- first attempts showed. Retail pairs saddle 205 with saddle005_base.blp and the pack saddle 207
-- with saddle008_base.blp; both files are served by CASCHost under their own identifiers.
--
-- Everything else in these rows is the client's own record, copied field for field.
--
-- TableHash 3218799089 is CreatureDisplayInfo.
-- ==========================================================================================

DELETE FROM `creature_display_info` WHERE `ID` IN
  (2402, 2404, 2405, 2408, 2409, 2410, 29975, 30518, 33316, 55440, 56486, 74024,
   38691, 39188, 39284, 39285, 39286, 39287);

INSERT INTO `creature_display_info`
  (`ID`, `CreatureModelScale`, `ModelID`, `NPCSoundID`, `SizeClass`, `Flags`, `Gender`,
   `ExtendedDisplayInfoID`, `PortraitTextureFileDataID`, `CreatureModelAlpha`, `SoundID`,
   `PlayerOverrideScale`, `PortraitCreatureDisplayInfoID`, `BloodID`, `ParticleColorID`,
   `DissolveEffectID`, `ObjectEffectPackageID`, `AnimReplacementSetID`, `UnarmedWeaponType`,
   `StateSpellVisualKitID`, `PetInstanceScale`, `MountPoofSpellVisualKitID`,
   `TextureVariationFileDataID1`, `TextureVariationFileDataID2`, `TextureVariationFileDataID3`,
   `VerifiedBuild`) VALUES
(2402, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125621, 1793546, 0, 26972),
(2404, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125622, 1793546, 0, 26972),
(2405, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125623, 1793546, 0, 26972),
(2408, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125624, 1793546, 0, 26972),
(2409, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125625, 1793546, 0, 26972),
(2410, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125626, 1793546, 0, 26972),
(29975, 1.25, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125626, 1793546, 0, 26972),
(30518, 0.80000001192, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125626, 1793546, 0, 26972),
(33316, 1.14999997616, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125626, 1793546, 0, 26972),
(55440, 1.20000004768, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125622, 1793546, 0, 26972),
(56486, 1.25, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125621, 1793546, 0, 26972),
(74024, 0.60000002384, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 81, 0, 0, -1, 0, 1, 0, 125623, 1793546, 0, 26972),
(38691, 0.5, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125608, 1793551, 0, 26972),
(39188, 0.5, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125605, 1793551, 0, 26972),
(39284, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125605, 1793551, 0, 26972),
(39285, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125606, 1793551, 0, 26972),
(39286, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125607, 1793551, 0, 26972),
(39287, 1, 216, 0, 1, 0, 2, 0, 0, 255, 0, 0, 0, 0, 0, 115, 0, 0, -1, 0, 1, 0, 125608, 1793551, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000331 AND 9000348;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000331, 3218799089,  2402, 0, 0),
(9000332, 3218799089,  2404, 0, 0),
(9000333, 3218799089,  2405, 0, 0),
(9000334, 3218799089,  2408, 0, 0),
(9000335, 3218799089,  2409, 0, 0),
(9000336, 3218799089,  2410, 0, 0),
(9000337, 3218799089, 29975, 0, 0),
(9000338, 3218799089, 30518, 0, 0),
(9000339, 3218799089, 33316, 0, 0),
(9000340, 3218799089, 55440, 0, 0),
(9000341, 3218799089, 56486, 0, 0),
(9000342, 3218799089, 74024, 0, 0),
(9000343, 3218799089, 38691, 0, 0),
(9000344, 3218799089, 39188, 0, 0),
(9000345, 3218799089, 39284, 0, 0),
(9000346, 3218799089, 39285, 0, 0),
(9000347, 3218799089, 39286, 0, 0),
(9000348, 3218799089, 39287, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 32;
