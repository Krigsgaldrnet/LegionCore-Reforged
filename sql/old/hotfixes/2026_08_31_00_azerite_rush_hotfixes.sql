-- ==========================================================================================
-- Azerite Rush - client side records
--
-- Three creations, none of them a modification of anything the client already ships:
--   * BattlemasterList 900, so the mode is listed by name in the PvP finder like any other
--     battleground. 894 (Seething Shore) is the last record the 7.3.5 client holds, so 900 is
--     free. Arathi Basin keeps record 3 untouched.
--   * Two taxi paths, 6800 and 6801, flown by the faction airships above the basin. The client
--     interpolates transport movement from its own copy of the path, so these are hotfixed out
--     as well and not merely inserted server side.
--   * Spell 900500, the mining channel. The server owns the timing and the interruption; this
--     record only exists so the player sees a cast bar.
--
-- Run against the hotfixes database, and apply the world file of the same date, which bumps
-- version.hotfix_cache_id. Without that bump the client keeps serving its cached tables.
-- ==========================================================================================

-- ------------------------------------------------------------------------------------------
-- BattlemasterList - TableHash 1435332686
-- Modelled on record 894: InstanceType 3 (battleground), no group queue, level 110 only.
-- Team size lives here: MinPlayers / MaxPlayers are the 10v10 of a large map. A smaller map
-- gets its own record with 5 / 5; the mode does not care.
-- ------------------------------------------------------------------------------------------
DELETE FROM `battlemaster_list` WHERE `ID` = 900;
INSERT INTO `battlemaster_list`
  (`ID`, `Name`, `GameType`, `ShortDescription`, `LongDescription`, `IconFileDataID`, `MapID1`, `HolidayWorldState`,
   `RequiredPlayer_Condition_ID`, `InstanceType`, `GroupsAllowed`, `MaxGroupSize`, `MinLevel`, `MaxLevel`,
   `RatedPlayers`, `MinPlayers`, `MaxPlayers`, `Flags`) VALUES
(900,
 'Ruée vers l''Azérite',
 'Extraire l''azérite',
 'Extrayez l''azérite avant vos adversaires.',
 'Des filons d''azérite affleurent un peu partout dans le bassin. Restez sur un filon pour l''extraire : le moindre coup encaissé interrompt l''extraction. Le premier camp à réunir 1500 unités d''azérite l''emporte.',
 0, 529, 0, 0, 3, 0, 1, 110, 110, 10, 10, 10, 24);

DELETE FROM `hotfix_data` WHERE `Id` = 9000221;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000221, 1435332686, 900, 0, 0);

-- ------------------------------------------------------------------------------------------
-- Taxi paths for the airships - TableHash 2872091740 (TaxiPath) / 3857287356 (TaxiPathNode)
--
-- 6800 flies over the alliance half, 6801 over the horde half; neither circle crosses the
-- other. Both are octagons of radius 180 at Z 200, roughly 180 yards above the highest ground
-- in the basin. The core drops the first and the last node of a transport path as spline
-- control points, so each list repeats its last point in front and its first point behind:
-- what is left is a closed ring whose wrap is a single short edge.
--
-- The client's highest taxi path is 6555 and its highest path node 110576, so nothing here
-- collides. FromTaxiNode / ToTaxiNode stay at 0: these paths are not flight routes and must
-- never appear on a flight master.
-- ------------------------------------------------------------------------------------------
DELETE FROM `taxi_path` WHERE `ID` IN (6800, 6801);
INSERT INTO `taxi_path` (`ID`, `FromTaxiNode`, `ToTaxiNode`, `Cost`) VALUES
(6800, 0, 0, 0),
(6801, 0, 0, 0);

DELETE FROM `taxi_path_node` WHERE `PathID` IN (6800, 6801);
INSERT INTO `taxi_path_node` (`ID`, `PathID`, `NodeIndex`, `ContinentID`, `LocX`, `LocY`, `LocZ`, `Flags`, `Delay`, `ArrivalEventID`, `DepartureEventID`) VALUES
-- 6800, alliance airship
(900000, 6800, 0, 529, 1277.3, 972.7, 200, 0, 0, 0, 0),
(900001, 6800, 1, 529, 1330.0, 1100.0, 200, 0, 0, 0, 0),
(900002, 6800, 2, 529, 1277.3, 1227.3, 200, 0, 0, 0, 0),
(900003, 6800, 3, 529, 1150.0, 1280.0, 200, 0, 0, 0, 0),
(900004, 6800, 4, 529, 1022.7, 1227.3, 200, 0, 0, 0, 0),
(900005, 6800, 5, 529,  970.0, 1100.0, 200, 0, 0, 0, 0),
(900006, 6800, 6, 529, 1022.7,  972.7, 200, 0, 0, 0, 0),
(900007, 6800, 7, 529, 1150.0,  920.0, 200, 0, 0, 0, 0),
(900008, 6800, 8, 529, 1277.3,  972.7, 200, 0, 0, 0, 0),
(900009, 6800, 9, 529, 1330.0, 1100.0, 200, 0, 0, 0, 0),
-- 6801, horde airship
(900010, 6801, 0, 529, 1037.3,  672.7, 200, 0, 0, 0, 0),
(900011, 6801, 1, 529, 1090.0,  800.0, 200, 0, 0, 0, 0),
(900012, 6801, 2, 529, 1037.3,  927.3, 200, 0, 0, 0, 0),
(900013, 6801, 3, 529,  910.0,  980.0, 200, 0, 0, 0, 0),
(900014, 6801, 4, 529,  782.7,  927.3, 200, 0, 0, 0, 0),
(900015, 6801, 5, 529,  730.0,  800.0, 200, 0, 0, 0, 0),
(900016, 6801, 6, 529,  782.7,  672.7, 200, 0, 0, 0, 0),
(900017, 6801, 7, 529,  910.0,  620.0, 200, 0, 0, 0, 0),
(900018, 6801, 8, 529, 1037.3,  672.7, 200, 0, 0, 0, 0),
(900019, 6801, 9, 529, 1090.0,  800.0, 200, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000222 AND 9000243;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000222, 2872091740, 6800, 0, 0),
(9000223, 2872091740, 6801, 0, 0),
(9000224, 3857287356, 900000, 0, 0),
(9000225, 3857287356, 900001, 0, 0),
(9000226, 3857287356, 900002, 0, 0),
(9000227, 3857287356, 900003, 0, 0),
(9000228, 3857287356, 900004, 0, 0),
(9000229, 3857287356, 900005, 0, 0),
(9000230, 3857287356, 900006, 0, 0),
(9000231, 3857287356, 900007, 0, 0),
(9000232, 3857287356, 900008, 0, 0),
(9000233, 3857287356, 900009, 0, 0),
(9000234, 3857287356, 900010, 0, 0),
(9000235, 3857287356, 900011, 0, 0),
(9000236, 3857287356, 900012, 0, 0),
(9000237, 3857287356, 900013, 0, 0),
(9000238, 3857287356, 900014, 0, 0),
(9000239, 3857287356, 900015, 0, 0),
(9000240, 3857287356, 900016, 0, 0),
(9000241, 3857287356, 900017, 0, 0),
(9000242, 3857287356, 900018, 0, 0),
(9000243, 3857287356, 900019, 0, 0);

-- ------------------------------------------------------------------------------------------
-- Mining channel, spell 900500
--
-- A four second channel with no effect of its own: the battleground counts the time, decides
-- when the node is taken and breaks the channel the moment the miner is hit. If this spell is
-- wrong or missing the mode still runs, the player simply loses the cast bar.
--
-- SpellDuration 1301 carries the four seconds. It must stay equal to
-- battleground_azerite_rush_map.ChannelDurationMs, which is what the server actually counts.
-- Client maxima: Spell 263316, SpellMisc 336496, SpellEffect 707840, SpellInterrupts 116728,
-- SpellDuration 893 - every id below is above its own table's ceiling.
-- ------------------------------------------------------------------------------------------
DELETE FROM `spell_duration` WHERE `ID` = 1301;
INSERT INTO `spell_duration` (`ID`, `Duration`, `MaxDuration`, `DurationPerLevel`) VALUES
(1301, 4000, 4000, 0);

DELETE FROM `spell` WHERE `ID` = 900500;
INSERT INTO `spell` (`ID`, `Name`, `NameSubtext`, `Description`, `AuraDescription`) VALUES
(900500, 'Extraction d''azérite', '', 'Extrait l''azérite du filon. Subir des dégâts interrompt l''extraction.', '');

-- CastingTimeIndex 1 is the instant entry; a channel takes its length from DurationIndex.
-- Attributes2 bit 2 is SPELL_ATTR1_CHANNELED_1.
DELETE FROM `spell_misc` WHERE `ID` = 900500;
INSERT INTO `spell_misc` (`ID`, `SpellID`, `DifficultyID`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`, `SchoolMask`, `Attributes2`) VALUES
(900500, 900500, 0, 1, 1301, 1, 1, 4);

-- One aura on the caster, purely so the channel has something to hold on to.
DELETE FROM `spell_effect` WHERE `ID` = 900500;
INSERT INTO `spell_effect` (`ID`, `SpellID`, `DifficultyID`, `EffectIndex`, `Effect`, `EffectAura`, `EffectBasePoints`, `ImplicitTarget1`, `ImplicitTarget2`) VALUES
(900500, 900500, 0, 0, 6, 4, 0, 1, 0);

-- ChannelInterruptFlags 43 = hit by spell, damage taken, movement, jump.
DELETE FROM `spell_interrupts` WHERE `ID` = 900500;
INSERT INTO `spell_interrupts` (`ID`, `SpellID`, `DifficultyID`, `InterruptFlags`, `AuraInterruptFlags1`, `ChannelInterruptFlags1`) VALUES
(900500, 900500, 0, 31, 0, 43);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000244 AND 9000248;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000244, 3776013982, 900500, 0, 0),
(9000245, 3322146344, 900500, 0, 0),
(9000246, 4030871717, 900500, 0, 0),
(9000247, 1720692227, 900500, 0, 0),
(9000248, 3022256762, 1301, 0, 0);
