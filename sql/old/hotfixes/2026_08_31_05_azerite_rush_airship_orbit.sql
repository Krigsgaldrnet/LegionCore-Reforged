-- ==========================================================================================
-- Azerite Rush - the airships circle the basin instead of their own corner
--
-- Each side used to fly a tight ring of radius 110 over its own half, which read as spinning in
-- place rather than patrolling. Both now share one ring around the whole battlefield:
--
--   centre (1050, 950), radius 340 - the basin runs roughly x 700-1400, y 600-1300
--   alliance enters at 45 degrees, north east, over its own base, Z 210
--   horde    enters at 225 degrees, south west, over its own base, Z 190
--
-- Same ring, same speed, half a revolution apart: they hold opposite sides of the map for the
-- whole match and can never meet. The two heights are kept as a second guarantee.
--
-- The core drops the first and the last node of a transport path as spline control points, so
-- each list repeats its last point in front and its first point behind. What survives is the
-- eight point loop, wrapping over a single edge.
-- ==========================================================================================

DELETE FROM `taxi_path_node` WHERE `PathID` IN (6800, 6801);
INSERT INTO `taxi_path_node` (`ID`, `PathID`, `NodeIndex`, `ContinentID`, `LocX`, `LocY`, `LocZ`, `Flags`, `Delay`, `ArrivalEventID`, `DepartureEventID`) VALUES
-- 6800, alliance, entering the ring at 45 degrees
(900000, 6800, 0, 529, 1390.0,  950.0, 210, 0, 0, 0, 0),
(900001, 6800, 1, 529, 1290.4, 1190.4, 210, 0, 0, 0, 0),
(900002, 6800, 2, 529, 1050.0, 1290.0, 210, 0, 0, 0, 0),
(900003, 6800, 3, 529,  809.6, 1190.4, 210, 0, 0, 0, 0),
(900004, 6800, 4, 529,  710.0,  950.0, 210, 0, 0, 0, 0),
(900005, 6800, 5, 529,  809.6,  709.6, 210, 0, 0, 0, 0),
(900006, 6800, 6, 529, 1050.0,  610.0, 210, 0, 0, 0, 0),
(900007, 6800, 7, 529, 1290.4,  709.6, 210, 0, 0, 0, 0),
(900008, 6800, 8, 529, 1390.0,  950.0, 210, 0, 0, 0, 0),
(900009, 6800, 9, 529, 1290.4, 1190.4, 210, 0, 0, 0, 0),
-- 6801, horde, entering the same ring at 225 degrees
(900010, 6801, 0, 529,  710.0,  950.0, 190, 0, 0, 0, 0),
(900011, 6801, 1, 529,  809.6,  709.6, 190, 0, 0, 0, 0),
(900012, 6801, 2, 529, 1050.0,  610.0, 190, 0, 0, 0, 0),
(900013, 6801, 3, 529, 1290.4,  709.6, 190, 0, 0, 0, 0),
(900014, 6801, 4, 529, 1390.0,  950.0, 190, 0, 0, 0, 0),
(900015, 6801, 5, 529, 1290.4, 1190.4, 190, 0, 0, 0, 0),
(900016, 6801, 6, 529, 1050.0, 1290.0, 190, 0, 0, 0, 0),
(900017, 6801, 7, 529,  809.6, 1190.4, 190, 0, 0, 0, 0),
(900018, 6801, 8, 529,  710.0,  950.0, 190, 0, 0, 0, 0),
(900019, 6801, 9, 529,  809.6,  709.6, 190, 0, 0, 0, 0);

-- The client interpolates transport movement from its own copy of the path.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 8;
