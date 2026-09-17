-- `.tele ct` pour la Confluence temporelle, au centre de la plateforme principale.
--
-- Les coordonnées sont l'origine du WMO de la plateforme, relevée dans le `MODF` de l'ADT :
-- monde_x = 17066,666 - pos.z, monde_y = 17066,666 - pos.x, monde_z = pos.y. Le sol est à 6116,58,
-- l'arrivée est posée un mètre au-dessus.
DELETE FROM `game_tele` WHERE `name` IN ('ct', 'ConfluenceTemporelle');
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES
 (2003, -1126.84, -4100.46, 6117.6, 0, 2678, 'ct'),
 (2004, -1126.84, -4100.46, 6117.6, 0, 2678, 'ConfluenceTemporelle');
