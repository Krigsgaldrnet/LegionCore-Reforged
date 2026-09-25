-- enable map 1651 Return to Karazhan
DELETE FROM disables WHERE sourceType = 2 AND entry IN (1651);

-- enable quest 45271/45260 Insurrection / One Day at a Time (starting quests of the Suramar Insurrection chapter)
-- enable quest 45422 Edict of the God-King (starting quest of the Karazhan attunement)
-- enable quest 44720 A Call to Action (starting quest of Helya's Conquest and the Trial of Valor quests)
DELETE FROM disables WHERE sourceType = 1 AND entry IN (45271, 45260, 45422, 44720);
