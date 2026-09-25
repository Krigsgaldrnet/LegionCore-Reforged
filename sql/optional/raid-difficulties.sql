-- Opens a Legion raid one difficulty and one Raid Finder wing at a time. Run by hand, then
-- `.reload disables` or restart the worldserver. Players already inside the raid stay inside.
--
-- Map rows (sourceType 2): flags = the closed difficulties, added up:
--   1 normal, 2 heroic, 4 mythic, 8 the whole Raid Finder, 16 timewalking. 0 closes the whole map.
-- LFG rows (sourceType 8): one closed Raid Finder wing, flags 0.
--
-- Raid                          Map    Raid Finder wings, in order
-- The Emerald Nightmare         1520   1287 Darkbough, 1288 Tormented Guardians, 1289 Rift of Aln
-- Trial of Valor                1648   1411 Trial of Valor
-- The Nighthold                 1530   1290 Arcing Aqueducts, 1291 Royal Athenaeum, 1292 Nightspire, 1293 Betrayer's Rise
-- Tomb of Sargeras              1676   1494 The Gates of Hell, 1495 Wailing Halls, 1496 Chamber of the Avatar, 1497 Deceiver's Fall
-- Antorus, the Burning Throne   1712   1610 Light's Breach, 1611 Forbidden Descent, 1612 Hope's End, 1613 Seat of the Pantheon
--
-- Example below: Antorus with normal and Raid Finder wings 1 to 3 open; heroic, mythic and wing 4 closed.
-- Each step of an opening replaces the raid's rows: delete them, then insert what stays closed.

DELETE FROM `disables` WHERE (`sourceType` = 2 AND `entry` = 1712) OR (`sourceType` = 8 AND `entry` IN (1610, 1611, 1612, 1613));
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(2, 1712, 6, 'Antorus, the Burning Throne - heroic and mythic closed'),
(8, 1613, 0, 'Antorus, the Burning Throne - Raid Finder wing 4 closed: Seat of the Pantheon');
