-- The three structures of map 2678, as gameobjects.
--
-- Blizzard's own data references these models but never places them: MODI lists them inside the
-- WMOs while MODD, which holds the placements, does not, because the dungeon's script spawns them.
-- Nothing in the terrain will ever show them, so they are placed here instead - as gameobjects,
-- which keeps them editable in game rather than frozen into a WMO's placement table.
--
-- Type 5 is GENERIC: no interaction, no loot, purely there to be seen. Data3 marks the two big
-- ones "large", which is what tells the client to keep drawing them from a distance.
--
-- VisibilityDistance is the per-object range added to the core for the Silithus sword. Without it
-- these would vanish at 90 yards, which for a structure 350 units tall is absurd.
--
-- Positions are around where the character stood on the floating platforms, so they can be seen
-- without hunting for them; .gobject move is the way to adjust from there.

DELETE FROM `gameobject_template` WHERE `entry` = 2600001;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`,
                                   `castBarCaption`, `unk1`, `faction`, `flags`, `size`,
                                   `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`,
                                   `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`,
                                   `Data12`, `Data13`, `Data14`, `Data15`, `Data16`,
                                   `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
                                   `Data22`, `Data23`, `Data24`, `Data25`, `Data26`,
                                   `Data27`, `Data28`, `Data29`, `Data30`, `Data31`,
                                   `Data32`, `unkInt32`, `AIName`, `ScriptName`,
                                   `SpellStateVisualID`, `SpellStateAnimID`,
                                   `SpellStateAnimKitID`, `MaxVisible`, `IgnoreDynLos`,
                                   `MinGold`, `MaxGold`, `VisibilityDistance`) VALUES
(2600001, 5, 60001, 'Sablier de la Confluence', '', '', '', 0, 0, 1,
 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 2000);

DELETE FROM `gameobject` WHERE `id` = 2600001;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
                          `phaseMask`, `PhaseId`, `position_x`, `position_y`, `position_z`,
                          `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
                          `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`,
                          `personal_size`) VALUES
(9200001, 2600001, 2678, 15010, 15010, 1, 1, '', -1900, -3400, 6100, 0, 0, 0, 0, 1, 300, 100, 0, 1, 0, 0);

DELETE FROM `gameobject_template` WHERE `entry` = 2600002;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`,
                                   `castBarCaption`, `unk1`, `faction`, `flags`, `size`,
                                   `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`,
                                   `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`,
                                   `Data12`, `Data13`, `Data14`, `Data15`, `Data16`,
                                   `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
                                   `Data22`, `Data23`, `Data24`, `Data25`, `Data26`,
                                   `Data27`, `Data28`, `Data29`, `Data30`, `Data31`,
                                   `Data32`, `unkInt32`, `AIName`, `ScriptName`,
                                   `SpellStateVisualID`, `SpellStateAnimID`,
                                   `SpellStateAnimKitID`, `MaxVisible`, `IgnoreDynLos`,
                                   `MinGold`, `MaxGold`, `VisibilityDistance`) VALUES
(2600002, 5, 60002, 'Portail flottant de la Confluence', '', '', '', 0, 0, 1,
 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 1500);

DELETE FROM `gameobject` WHERE `id` = 2600002;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
                          `phaseMask`, `PhaseId`, `position_x`, `position_y`, `position_z`,
                          `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
                          `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`,
                          `personal_size`) VALUES
(9200002, 2600002, 2678, 15010, 15010, 1, 1, '', -1758, -3286, 6180, 0, 0, 0, 0, 1, 300, 100, 0, 1, 0, 0);

DELETE FROM `gameobject_template` WHERE `entry` = 2600003;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`,
                                   `castBarCaption`, `unk1`, `faction`, `flags`, `size`,
                                   `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`,
                                   `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`,
                                   `Data12`, `Data13`, `Data14`, `Data15`, `Data16`,
                                   `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
                                   `Data22`, `Data23`, `Data24`, `Data25`, `Data26`,
                                   `Data27`, `Data28`, `Data29`, `Data30`, `Data31`,
                                   `Data32`, `unkInt32`, `AIName`, `ScriptName`,
                                   `SpellStateVisualID`, `SpellStateAnimID`,
                                   `SpellStateAnimKitID`, `MaxVisible`, `IgnoreDynLos`,
                                   `MinGold`, `MaxGold`, `VisibilityDistance`) VALUES
(2600003, 5, 60003, 'Porte temporelle', '', '', '', 0, 0, 1,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 800);

DELETE FROM `gameobject` WHERE `id` = 2600003;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`,
                          `phaseMask`, `PhaseId`, `position_x`, `position_y`, `position_z`,
                          `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
                          `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`,
                          `personal_size`) VALUES
(9200003, 2600003, 2678, 15010, 15010, 1, 1, '', -1728, -3286, 6215, 0, 0, 0, 0, 1, 300, 100, 0, 1, 0, 0);

