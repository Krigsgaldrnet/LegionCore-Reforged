-- ==========================================================================================
-- Azerite Rush - close the airship loop so the wrap stops showing
--
-- TransportMgr::GeneratePath always ends a path with a teleport from the last keyframe back to
-- the first, closed circuit or not. The kept keyframes ran 45 to 0 degrees, so every lap ended
-- with the ship jumping 184 yards back to its entry point - which reads exactly as a position
-- reset, and became visible once a lap dropped to a hundred seconds.
--
-- The core drops the first and the last node of the list as spline control points. The fix is
-- therefore to make what survives start and end on the same point: the entry point is repeated
-- at the end, so the closing teleport covers zero distance.
--
--   list      : control, P0 .. P7, P0, control      (11 nodes)
--   keyframes : P0 .. P7, P0                        (9, first and last identical)
--
-- Ring and phases unchanged: centre (1050, 950) radius 240, alliance entering at 45 degrees,
-- horde at 225, half a revolution apart, Z 210 and Z 190.
-- ==========================================================================================

DELETE FROM `taxi_path_node` WHERE `PathID` IN (6800, 6801);
INSERT INTO `taxi_path_node` (`ID`, `PathID`, `NodeIndex`, `ContinentID`, `LocX`, `LocY`, `LocZ`, `Flags`, `Delay`, `ArrivalEventID`, `DepartureEventID`) VALUES
-- 6800, alliance: control 0deg, then the loop from 45deg round to 45deg, then control 90deg
(900000, 6800,  0, 529, 1290.0,  950.0, 210, 0, 0, 0, 0),
(900001, 6800,  1, 529, 1219.7, 1119.7, 210, 0, 0, 0, 0),
(900002, 6800,  2, 529, 1050.0, 1190.0, 210, 0, 0, 0, 0),
(900003, 6800,  3, 529,  880.3, 1119.7, 210, 0, 0, 0, 0),
(900004, 6800,  4, 529,  810.0,  950.0, 210, 0, 0, 0, 0),
(900005, 6800,  5, 529,  880.3,  780.3, 210, 0, 0, 0, 0),
(900006, 6800,  6, 529, 1050.0,  710.0, 210, 0, 0, 0, 0),
(900007, 6800,  7, 529, 1219.7,  780.3, 210, 0, 0, 0, 0),
(900008, 6800,  8, 529, 1290.0,  950.0, 210, 0, 0, 0, 0),
(900009, 6800,  9, 529, 1219.7, 1119.7, 210, 0, 0, 0, 0),
(900010, 6800, 10, 529, 1050.0, 1190.0, 210, 0, 0, 0, 0),
-- 6801, horde: control 180deg, then the loop from 225deg round to 225deg, then control 270deg
(900011, 6801,  0, 529,  810.0,  950.0, 190, 0, 0, 0, 0),
(900012, 6801,  1, 529,  880.3,  780.3, 190, 0, 0, 0, 0),
(900013, 6801,  2, 529, 1050.0,  710.0, 190, 0, 0, 0, 0),
(900014, 6801,  3, 529, 1219.7,  780.3, 190, 0, 0, 0, 0),
(900015, 6801,  4, 529, 1290.0,  950.0, 190, 0, 0, 0, 0),
(900016, 6801,  5, 529, 1219.7, 1119.7, 190, 0, 0, 0, 0),
(900017, 6801,  6, 529, 1050.0, 1190.0, 190, 0, 0, 0, 0),
(900018, 6801,  7, 529,  880.3, 1119.7, 190, 0, 0, 0, 0),
(900019, 6801,  8, 529,  810.0,  950.0, 190, 0, 0, 0, 0),
(900020, 6801,  9, 529,  880.3,  780.3, 190, 0, 0, 0, 0),
(900021, 6801, 10, 529, 1050.0,  710.0, 190, 0, 0, 0, 0);

-- Two nodes more than the previous layout, so two hotfix rows to add.
DELETE FROM `hotfix_data` WHERE `Id` IN (9000276, 9000277);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000276, 3857287356, 900020, 0, 0),
(9000277, 3857287356, 900021, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 10;
