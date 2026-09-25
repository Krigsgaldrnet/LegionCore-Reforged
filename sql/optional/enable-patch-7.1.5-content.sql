-- enable quest 46119 Boon of the Builder (engineering)
DELETE FROM disables WHERE sourceType = 1 AND entry IN (46119);

-- enable the 7.1.5 micro-holidays and the Mists of Pandaria Timewalking event, with the start times of the shipped
-- world database
UPDATE game_event SET start_time = '2019-02-23 19:00:00' WHERE eventEntry = 69;
UPDATE game_event SET start_time = '2019-04-28 21:00:00' WHERE eventEntry = 70;
UPDATE game_event SET start_time = '2019-01-21 09:01:00' WHERE eventEntry = 78;
UPDATE game_event SET start_time = '2019-01-31 19:00:00' WHERE eventEntry = 86;
UPDATE game_event SET start_time = '2018-05-10 09:00:00' WHERE eventEntry = 87;
UPDATE game_event SET start_time = '2018-05-09 11:00:00' WHERE eventEntry = 98;
UPDATE game_event SET start_time = '2018-05-27 21:00:00' WHERE eventEntry = 301;
UPDATE game_event SET start_time = '2019-04-05 09:01:00' WHERE eventEntry = 305;
UPDATE game_event SET start_time = '2019-01-24 09:00:00' WHERE eventEntry = 306;
UPDATE game_event SET start_time = '2019-06-06 09:01:00' WHERE eventEntry = 307;
