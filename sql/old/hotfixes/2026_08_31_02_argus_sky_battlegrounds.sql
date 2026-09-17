-- ==========================================================================================
-- Argus in the sky of the battleground and arena maps
--
-- MapCelestialBody attaches a celestial body to a map. The client ships 14 records covering
-- seven maps; battleground and arena maps were never among them, so Argus vanished the moment
-- a player zoned into one. Nothing needs to be written on the server side: the packet that makes
-- the client redraw its sky is already sent on every map without exception
-- (Player::SendInitialPacketsAfterAddToMap).
--
-- Body 9 is the full planet. PlayerCondition 54101 is the one the core already strips of its
-- AuraSpellID so the planet shows without an aura being applied. The post-Antorus glow (body 20)
-- stays out, exactly as on the open world maps.
--
-- Client maxima: MapCelestialBody max_id = 15, so the 100 range is free. TableHash 2523168314.
--
-- Run against the hotfixes database. The world file of the same date bumps hotfix_cache_id.
-- ==========================================================================================

DELETE FROM `map_celestial_body` WHERE `ID` BETWEEN 101 AND 125;
INSERT INTO `map_celestial_body` (`ID`, `CelestialBodyID`, `PlayerConditionID`, `MapID`) VALUES
-- Battlegrounds
(101,  9, 54101,   30),   -- Alterac Valley
(102,  9, 54101,  489),   -- Warsong Gulch
(103,  9, 54101,  529),   -- Arathi Basin
(104,  9, 54101,  566),   -- Eye of the Storm
(105,  9, 54101,  607),   -- Strand of the Ancients
(106,  9, 54101,  628),   -- Isle of Conquest
(107,  9, 54101,  726),   -- Twin Peaks
(108,  9, 54101,  727),   -- Silvershard Mines
(109,  9, 54101,  761),   -- Battle for Gilneas
(110,  9, 54101,  968),   -- Eye of the Storm, rated
(111,  9, 54101,  998),   -- Temple of Kotmogu
(112,  9, 54101, 1105),   -- Deepwind Gorge
(113,  9, 54101, 1681),   -- Arathi Basin, winter
(114,  9, 54101, 1803),   -- Seething Shore
-- Arenas that stand on Azeroth
(115,  9, 54101,  572),   -- Ruins of Lordaeron
(116,  9, 54101,  617),   -- Dalaran Sewers
(117,  9, 54101,  618),   -- Ring of Valor
(118,  9, 54101,  980),   -- Tol'viron Arena
(119,  9, 54101, 1134),   -- The Tiger's Peak
(120,  9, 54101, 1504),   -- Black Rook Hold Arena
(121,  9, 54101, 1552);   -- Ashamane's Fall

-- Deliberately left out, same reasoning that removed Outland: these four arenas stand on another
-- world, and the portal links Argus to Azeroth, not to Outland or Draenor. Uncomment to include
-- them anyway.
-- (122,  9, 54101,  559),   -- Nagrand Arena, Outland
-- (123,  9, 54101,  562),   -- Blade's Edge Arena, Outland
-- (124,  9, 54101, 1505),   -- Nagrand Arena, Draenor
-- (125,  9, 54101, 1672),   -- Blade's Edge Arena, Outland

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000249 AND 9000269;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000249, 2523168314, 101, 0, 0),
(9000250, 2523168314, 102, 0, 0),
(9000251, 2523168314, 103, 0, 0),
(9000252, 2523168314, 104, 0, 0),
(9000253, 2523168314, 105, 0, 0),
(9000254, 2523168314, 106, 0, 0),
(9000255, 2523168314, 107, 0, 0),
(9000256, 2523168314, 108, 0, 0),
(9000257, 2523168314, 109, 0, 0),
(9000258, 2523168314, 110, 0, 0),
(9000259, 2523168314, 111, 0, 0),
(9000260, 2523168314, 112, 0, 0),
(9000261, 2523168314, 113, 0, 0),
(9000262, 2523168314, 114, 0, 0),
(9000263, 2523168314, 115, 0, 0),
(9000264, 2523168314, 116, 0, 0),
(9000265, 2523168314, 117, 0, 0),
(9000266, 2523168314, 118, 0, 0),
(9000267, 2523168314, 119, 0, 0),
(9000268, 2523168314, 120, 0, 0),
(9000269, 2523168314, 121, 0, 0);

-- The client caches hotfixes; without this bump it keeps serving the old MapCelestialBody.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 6;
