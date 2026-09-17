-- ==========================================================================================
-- Azerite Rush - pull the airship ring back inside the basin
--
-- Radius 340 put the ships at x 710-1390 and y 610-1290, right up against the edge of the
-- playable ground: from the deck the map ran out just below. Radius 240 keeps the same shape
-- well inside it, x 810-1290 and y 710-1190, roughly a hundred yards clear of the border all
-- the way round.
--
-- Everything else is unchanged: one ring shared by both sides, alliance entering at 45 degrees
-- over its own base and horde at 225, half a revolution apart so they never meet, at Z 210
-- and Z 190.
--
-- The ring is now about 1510 yards around; at speed 15 that is close to a hundred seconds a lap.
-- ==========================================================================================

DELETE FROM `taxi_path_node` WHERE `PathID` IN (6800, 6801);
INSERT INTO `taxi_path_node` (`ID`, `PathID`, `NodeIndex`, `ContinentID`, `LocX`, `LocY`, `LocZ`, `Flags`, `Delay`, `ArrivalEventID`, `DepartureEventID`) VALUES
-- 6800, alliance, entering the ring at 45 degrees
(900000, 6800, 0, 529, 1290.0,  950.0, 210, 0, 0, 0, 0),
(900001, 6800, 1, 529, 1219.7, 1119.7, 210, 0, 0, 0, 0),
(900002, 6800, 2, 529, 1050.0, 1190.0, 210, 0, 0, 0, 0),
(900003, 6800, 3, 529,  880.3, 1119.7, 210, 0, 0, 0, 0),
(900004, 6800, 4, 529,  810.0,  950.0, 210, 0, 0, 0, 0),
(900005, 6800, 5, 529,  880.3,  780.3, 210, 0, 0, 0, 0),
(900006, 6800, 6, 529, 1050.0,  710.0, 210, 0, 0, 0, 0),
(900007, 6800, 7, 529, 1219.7,  780.3, 210, 0, 0, 0, 0),
(900008, 6800, 8, 529, 1290.0,  950.0, 210, 0, 0, 0, 0),
(900009, 6800, 9, 529, 1219.7, 1119.7, 210, 0, 0, 0, 0),
-- 6801, horde, entering the same ring at 225 degrees
(900010, 6801, 0, 529,  810.0,  950.0, 190, 0, 0, 0, 0),
(900011, 6801, 1, 529,  880.3,  780.3, 190, 0, 0, 0, 0),
(900012, 6801, 2, 529, 1050.0,  710.0, 190, 0, 0, 0, 0),
(900013, 6801, 3, 529, 1219.7,  780.3, 190, 0, 0, 0, 0),
(900014, 6801, 4, 529, 1290.0,  950.0, 190, 0, 0, 0, 0),
(900015, 6801, 5, 529, 1219.7, 1119.7, 190, 0, 0, 0, 0),
(900016, 6801, 6, 529, 1050.0, 1190.0, 190, 0, 0, 0, 0),
(900017, 6801, 7, 529,  880.3, 1119.7, 190, 0, 0, 0, 0),
(900018, 6801, 8, 529,  810.0,  950.0, 190, 0, 0, 0, 0),
(900019, 6801, 9, 529,  880.3,  780.3, 190, 0, 0, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 9;
