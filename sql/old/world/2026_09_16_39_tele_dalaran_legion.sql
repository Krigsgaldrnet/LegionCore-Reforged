-- `.tele dalaranlegion` pour la Dalaran de Legion, celle qui flotte au-dessus des Îles Brisées.
--
-- Deux points y menaient déjà, `Dal70` et `NewDalaran`, mais sous des noms qui ne disent pas de
-- quelle Dalaran il s'agit — il y en a trois dans la base, dont celle de Norfendre sur la carte 571
-- et le cratère sur la 0. Les coordonnées reprennent celles de `Dal70`, éprouvées.
DELETE FROM `game_tele` WHERE `name` = 'DalaranLegion';
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES
 (2002, -881.255, 4423.71, 737.56, 4.03, 1220, 'DalaranLegion');
