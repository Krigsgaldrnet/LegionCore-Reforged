-- Full-screen departure effect for both Confluence portals.
--
-- `SpellVisualEffectName`'s column names are shifted in 7.3.5: the record actually holds the scale
-- where `BaseMissileSpeed` sits and the model where `TextureFileDataID` sits. The values below are
-- copied position by position from native record 100 (spells/teleport.m2), only the model changes.
--
-- The model is `spells/fx_teleporttovoidstorm_aura.m2`, served by CASCHost under 7506447.
DELETE FROM `spell_visual_effect_name` WHERE `ID` = 31936;
INSERT INTO `spell_visual_effect_name`
 (`ID`, `ModelFileDataID`, `EffectRadius`, `BaseMissileSpeed`, `Scale`, `MinAllowedScale`,
  `MaxAllowedScale`, `Alpha`, `Flags`, `Type`, `GenericID`, `TextureFileDataID`, `RibbonQualityID`,
  `DissolveEffectID`, `VerifiedBuild`) VALUES
 (31936, 0, 0, 1, 0.01, 100, 1, 0, 0, 0, 0, 7506447, 0, 0, 26972);

-- Attachment 127 is the one native teleports use: the model is placed on the player rather than on
-- a bone, which is what lets an enveloping aura fill the screen.
DELETE FROM `spell_visual_kit_model_attach` WHERE `ID` = 362378;
INSERT INTO `spell_visual_kit_model_attach`
 (`Offset1`, `Offset2`, `Offset3`, `OffsetVariation1`, `OffsetVariation2`, `OffsetVariation3`,
  `ID`, `SpellVisualEffectNameID`, `AttachmentID`, `Flags`, `PositionerID`, `Yaw`, `Pitch`, `Roll`,
  `YawVariation`, `PitchVariation`, `RollVariation`, `Scale`, `ScaleVariation`, `StartAnimID`,
  `AnimID`, `EndAnimID`, `AnimKitID`, `LowDefModelAttachID`, `StartDelay`, `SpellVisualKitID`,
  `VerifiedBuild`) VALUES
 (0, 0, 0, 0, 0, 0, 362378, 31936, 127, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 65535, 65535, 65535, 0, 0, 0,
  94941, 26972);

DELETE FROM `spell_visual_kit` WHERE `ID` = 94941;
INSERT INTO `spell_visual_kit` (`ID`, `Flags`, `FallbackPriority`, `FallbackSpellVisualKitID`,
  `DelayMin`, `DelayMax`, `VerifiedBuild`) VALUES
 (94941, 0, 0, 0, 0, 0, 26972);

-- Effect type 2 designates a model attachment, type 5 a sound kit: the one-shot teleport sound.
DELETE FROM `spell_visual_kit_effect` WHERE `ID` IN (222251, 222248);
INSERT INTO `spell_visual_kit_effect` (`ID`, `EffectType`, `Effect`, `SpellVisualKitID`, `VerifiedBuild`) VALUES
 (222251, 2, 362378, 94941, 26972),
 (222248, 5, 98322, 94941, 26972);

-- A visual of its own so the two portal spells can carry the effect: casting either one plays it.
DELETE FROM `spell_visual` WHERE `ID` = 74690;
INSERT INTO `spell_visual`
 (`ID`, `MissileCastOffset1`, `MissileCastOffset2`, `MissileCastOffset3`, `MissileImpactOffset1`,
  `MissileImpactOffset2`, `MissileImpactOffset3`, `Flags`, `SpellVisualMissileSetID`,
  `MissileDestinationAttachment`, `MissileAttachment`, `MissileCastPositionerID`,
  `MissileImpactPositionerID`, `MissileTargetingKit`, `AnimEventSoundID`, `DamageNumberDelay`,
  `HostileSpellVisualID`, `CasterSpellVisualID`, `LowViolenceSpellVisualID`, `VerifiedBuild`) VALUES
 (74690, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26972);

-- The two events mirror native visual 38616 : one on cast start, one on cast finish.
DELETE FROM `spell_visual_event` WHERE `ID` IN (165925, 165924);
INSERT INTO `spell_visual_event`
 (`ID`, `StartEvent`, `StartMinOffsetMs`, `StartMaxOffsetMs`, `EndEvent`, `EndMinOffsetMs`,
  `EndMaxOffsetMs`, `TargetType`, `SpellVisualKitID`, `SpellVisualID`, `VerifiedBuild`) VALUES
 (165925, 1, 0, 0, 2, 0, 0, 1, 94941, 74690, 26972),
 (165924, 3, 0, 0, 13, 0, 0, 1, 94941, 74690, 26972);

DELETE FROM `spell_x_spell_visual` WHERE `ID` IN (251496, 251495);
INSERT INTO `spell_x_spell_visual`
 (`SpellVisualID`, `ID`, `Probability`, `CasterPlayerConditionID`, `CasterUnitConditionID`,
  `ViewerPlayerConditionID`, `ViewerUnitConditionID`, `SpellIconFileID`, `ActiveIconFileID`,
  `Flags`, `DifficultyID`, `Priority`, `SpellID`, `VerifiedBuild`) VALUES
 (74690, 251496, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 259125, 26972),
 (74690, 251495, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 259122, 26972);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000600 AND 9000609;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000600,   48336690, 31936, 0, 0),   -- SpellVisualEffectName
 (9000601, 4033975491, 362378, 0, 0),  -- SpellVisualKitModelAttach
 (9000602, 4102286043, 94941, 0, 0),   -- SpellVisualKit
 (9000603, 1181150530, 222251, 0, 0),  -- SpellVisualKitEffect
 (9000604, 1181150530, 222248, 0, 0),
 (9000605, 4146370265, 74690, 0, 0),   -- SpellVisual
 (9000606, 3425193231, 165925, 0, 0),  -- SpellVisualEvent
 (9000607, 3425193231, 165924, 0, 0),
 (9000608, 666345498, 251496, 0, 0),  -- SpellXSpellVisual
 (9000609, 666345498, 251495, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 139;
