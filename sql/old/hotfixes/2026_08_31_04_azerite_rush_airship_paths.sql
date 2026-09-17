-- ==========================================================================================
-- Azerite Rush - pull the two airships apart
--
-- The first pair of paths circled radius 180 around centres only 384 yards apart, leaving some
-- 24 yards between the two rings. A gunship is roughly a hundred yards long, so the two ships
-- overlapped on screen whenever they were on the same side of their circles - they read as one
-- doubled alliance ship.
--
-- Each side now circles its own half of the basin on a tighter ring, and the two sit at
-- different heights so nothing can line up even head on:
--   alliance  centre (1230, 1180) radius 110, Z 210, near its own starting base
--   horde     centre ( 830,  720) radius 110, Z 190
-- Centres are 610 yards apart, leaving about 390 yards between the rings.
--
-- The core drops the first and the last node of a transport path as spline control points, so
-- each list repeats its last point in front and its first point behind.
-- ==========================================================================================

DELETE FROM `taxi_path_node` WHERE `PathID` IN (6800, 6801);
INSERT INTO `taxi_path_node` (`ID`, `PathID`, `NodeIndex`, `ContinentID`, `LocX`, `LocY`, `LocZ`, `Flags`, `Delay`, `ArrivalEventID`, `DepartureEventID`) VALUES
-- 6800, alliance airship, north east
(900000, 6800, 0, 529, 1307.8, 1102.2, 210, 0, 0, 0, 0),
(900001, 6800, 1, 529, 1340.0, 1180.0, 210, 0, 0, 0, 0),
(900002, 6800, 2, 529, 1307.8, 1257.8, 210, 0, 0, 0, 0),
(900003, 6800, 3, 529, 1230.0, 1290.0, 210, 0, 0, 0, 0),
(900004, 6800, 4, 529, 1152.2, 1257.8, 210, 0, 0, 0, 0),
(900005, 6800, 5, 529, 1120.0, 1180.0, 210, 0, 0, 0, 0),
(900006, 6800, 6, 529, 1152.2, 1102.2, 210, 0, 0, 0, 0),
(900007, 6800, 7, 529, 1230.0, 1070.0, 210, 0, 0, 0, 0),
(900008, 6800, 8, 529, 1307.8, 1102.2, 210, 0, 0, 0, 0),
(900009, 6800, 9, 529, 1340.0, 1180.0, 210, 0, 0, 0, 0),
-- 6801, horde airship, south west
(900010, 6801, 0, 529,  907.8,  642.2, 190, 0, 0, 0, 0),
(900011, 6801, 1, 529,  940.0,  720.0, 190, 0, 0, 0, 0),
(900012, 6801, 2, 529,  907.8,  797.8, 190, 0, 0, 0, 0),
(900013, 6801, 3, 529,  830.0,  830.0, 190, 0, 0, 0, 0),
(900014, 6801, 4, 529,  752.2,  797.8, 190, 0, 0, 0, 0),
(900015, 6801, 5, 529,  720.0,  720.0, 190, 0, 0, 0, 0),
(900016, 6801, 6, 529,  752.2,  642.2, 190, 0, 0, 0, 0),
(900017, 6801, 7, 529,  830.0,  610.0, 190, 0, 0, 0, 0),
(900018, 6801, 8, 529,  907.8,  642.2, 190, 0, 0, 0, 0),
(900019, 6801, 9, 529,  940.0,  720.0, 190, 0, 0, 0, 0);

-- The client interpolates transport movement from its own copy of the path, so the new
-- coordinates have to reach it: bump the cache or it keeps flying the old rings.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 7;
