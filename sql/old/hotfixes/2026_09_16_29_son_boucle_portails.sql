-- Looping ambience for the two Confluence portals.
--
-- `ObjectEffect` was the wrong door: of 82 native packages none belongs to a portal, they dress
-- elevators and traps. Native looping ambience is placed instead as a `SoundEmitters` point, which
-- is a position on a map rather than something hung off a display - so it also survives a model
-- change.
--
-- The emitter table could never carry its map before: the hotfix statement dropped the parent
-- column, and a column count that does not match the record layout makes the server discard the
-- whole table without a word. Fixed in HotfixDatabase.cpp along with four others.

-- Conventions read from the 728 kits native emitters use: SoundType 52 (ambience), Flags 512
-- (loop), MinDistance 8-20, cutoff 45-80.
UPDATE `sound_kit` SET `SoundType` = 52, `Flags` = 512, `MinDistance` = 12, `DistanceCutoff` = 60
 WHERE `ID` = 98323;

DELETE FROM `sound_emitters` WHERE `ID` BETWEEN 11620 AND 11623;
INSERT INTO `sound_emitters`
 (`Name`, `Position1`, `Position2`, `Position3`, `Direction1`, `Direction2`, `Direction3`,
  `WorldStateExpressionID`, `PhaseID`, `EmitterType`, `PhaseUseFlags`, `Flags`, `ID`,
  `SoundEntriesID`, `PhaseGroupID`, `MapID`, `VerifiedBuild`) VALUES
 ('ConfluencePortalEntry', -1743.95, -3235.84, 6235.91, 0, 0, 0, 0, 0, 0, 0, 0, 11623, 98323, 0, 2678, 26972),
 ('ConfluencePortalDream', -1727.63, -3408.91, 6206.78, 0, 0, 0, 0, 0, 0, 0, 0, 11622, 98323, 0, 2678, 26972),
 ('ConfluencePortalExit',  -1289.01,  4495.04,  658.90, 0, 0, 0, 0, 0, 0, 0, 0, 11621, 98323, 0, 1220, 26972);

-- SoundKit 98323 already has its own hotfix_data row from the file that created it.
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000611 AND 9000614;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000612, 3325606100, 11623, 0, 0),   -- SoundEmitters
 (9000613, 3325606100, 11622, 0, 0),
 (9000614, 3325606100, 11621, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 141;
