-- Les tendrils du Vide, en type 14 (MAP_OBJECT) et non plus 5 (GENERIC).
--
-- Relevé sur les données natives de 7.3.5 : le type 5 ne porte un affichage WMO que 31 fois contre
-- 14 310 affichages M2, alors que MAP_OBJECT en compte 35 sur 367 et que DESTRUCTIBLE_BUILDING n'en
-- porte que des WMO. Un gameobject de type 5 affichant un WMO plantait le client - y compris avec un
-- modèle entièrement natif, donc ce n'était pas le fichier importé.
--
-- Une seule apparition pour commencer : si le client tient, la seconde suit.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600009, 2600010);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`) VALUES
 (2600009, 14, 47603, 'Tendril du Vide', 1),
 (2600010, 14, 47604, 'Tendril du Vide II', 1);

DELETE FROM `gameobject` WHERE `id` IN (2600009, 2600010);
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681045, 2600009, 2678, 15010, 15010, 1, 1, '',
  -1197.17, -4036.97, 6120.13, 0.72431, 0, 0, SIN(0.72431/2), COS(0.72431/2),
  300, 0, 0, 1, 1, 0);
