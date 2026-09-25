-- disable quest 46119 Boon of the Builder (engineering)
DELETE FROM disables WHERE sourceType = 1 AND entry IN (46119);
INSERT INTO disables (`sourceType`, `entry`, `comment`) VALUES
(1, 46119, '7.1.5 content - Boon of the Builder');

-- disable the 7.1.5 micro-holidays and the Mists of Pandaria Timewalking event
-- 69 Hatching of the Hippogryphs, 70 Volunteer Guard Day, 78/306 Call of the Scarab, 86 Kirin Tor Tavern Crawl,
-- 87 Spring Balloon Festival, 98 Mists of Pandaria Timewalking, 301 Glowcap Festival, 305 March of the Tadpoles,
-- 307 Thousand Boat Bash
UPDATE game_event SET start_time = '2035-07-04 17:00:00' WHERE eventEntry IN (69, 70, 78, 86, 87, 98, 301, 305, 306, 307);
