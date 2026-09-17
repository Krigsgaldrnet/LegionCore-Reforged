-- Les trois WMO importés du Vide, posés en gameobjects de type 14 (MAP_OBJECT).
--
-- Un décor d'ADT ne s'affiche pas à cette altitude : le terrain de la tuile est à -2400, les
-- plateformes à 6276, soit 8700 unités au-dessus. Un gameobject n'est rattaché à aucun chunk de
-- terrain, c'est ce qui le rend utilisable ici. Et un WMO ne peut pas être un décor interne de WMO,
-- un MODD ne référençant que des M2 - d'où le passage par des objets à part entière.
DELETE FROM `gameobject_template` WHERE `entry` = 2600011;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`) VALUES
 (2600011, 14, 47607, 'Structure du Vide', 1);

DELETE FROM `gameobject` WHERE `id` IN (2600010, 2600011);
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681046, 2600010, 2678, 15010, 15010, 1, 1, '',
  -1184.93, -4058.39, 6164.88, 0.72431, 0, 0, SIN(0.72431/2), COS(0.72431/2), 300, 0, 0, 1, 1, 0),
 (25681047, 2600011, 2678, 15010, 15010, 1, 1, '',
  -1070.00, -4102.00, 6112.00, 0.72431, 0, 0, SIN(0.72431/2), COS(0.72431/2), 300, 0, 0, 1, 1, 0);
