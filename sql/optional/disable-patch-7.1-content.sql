-- disable map 1651 Return to Karazhan
DELETE FROM disables WHERE sourceType = 2 AND entry IN (1651);
INSERT INTO disables (`sourceType`, `entry`, `comment`) VALUES
(2, 1651, '7.1 content - Return to Karazhan');

-- disable quest 45271/45260 Insurrection / One Day at a Time (starting quests of the Suramar Insurrection chapter)
-- disable quest 45422 Edict of the God-King (starting quest of the Karazhan attunement)
-- disable quest 44720 A Call to Action (starting quest of Helya's Conquest and the Trial of Valor quests)
-- (Trial of Valor itself opens from worldserver.conf, RAID OPENING)
DELETE FROM disables WHERE sourceType = 1 AND entry IN (45271, 45260, 45422, 44720);
INSERT INTO disables (`sourceType`, `entry`, `comment`) VALUES
(1, 45271, '7.1 content - Insurrection'),
(1, 45260, '7.1 content - One Day at a Time'),
(1, 45422, '7.1 content - Edict of the God-King'),
(1, 44720, '7.1 content - A Call to Action');
