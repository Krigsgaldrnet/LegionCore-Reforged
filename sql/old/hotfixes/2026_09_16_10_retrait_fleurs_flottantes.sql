-- Affichages des deux massifs de fleurs flottantes, retirés avec leurs gameobjects.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47632, 47633);
DELETE FROM `hotfix_data` WHERE `Id` IN (9000541, 9000542);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 121;
