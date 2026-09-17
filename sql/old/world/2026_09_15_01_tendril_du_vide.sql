-- Le tendril du Vide prend la place du char à vapeur sur la plateforme du champ de bataille.
--
-- Position calculée depuis le décor qu'il remplace : le char était à (-94.16, 4.15, 10.61) dans le
-- repère local de 10du_infinitedungeon_battlefield01, lui-même posé en (21167.13, 6115.98, 18193.50)
-- avec un lacet de 41,5 degrés. Le décor d'origine est masqué par la table MASQUES du convertisseur.
--
-- type 5 (GENERIC) : aucune interaction, c'est un décor.
DELETE FROM `gameobject_template` WHERE `entry` = 2600007;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`) VALUES
 (2600007, 5, 47603, 'Tendril du Vide', 1);

DELETE FROM `gameobject` WHERE `id` = 2600007;
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681043, 2600007, 2678, 15010, 15010, 1, 1, '',
  -1197.17, -4036.97, 6120.13, 0.72431, 0, 0, SIN(0.72431/2), COS(0.72431/2),
  300, 0, 0, 1, 1, 0);
