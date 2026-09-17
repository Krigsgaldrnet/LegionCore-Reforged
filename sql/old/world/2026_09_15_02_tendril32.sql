-- Le tendril 32 prend la place de l'Ashbringer.
--
-- Position calculée depuis le décor qu'il remplace : l'épée était à (-70.00, 48.90, 15.63) dans le
-- repère local de 10du_infinitedungeon_battlefield01, échelle 1,60. Le décor d'origine est masqué
-- par la table MASQUES du convertisseur.
DELETE FROM `gameobject_template` WHERE `entry` = 2600008;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`) VALUES
 (2600008, 5, 47604, 'Tendril du Vide II', 1);

DELETE FROM `gameobject` WHERE `id` = 2600008;
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681044, 2600008, 2678, 15010, 15010, 1, 1, '',
  -1184.93, -4058.39, 6164.88, 0.72431, 0, 0, SIN(0.72431/2), COS(0.72431/2),
  300, 0, 0, 1, 1, 0);
