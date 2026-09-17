-- Portail du Vide : type 22 (SPELLCASTER), celui que Blizzard emploie pour ses portails.
--
-- Data0 recevra le sort de téléportation, Data1 reste à 0 - le nombre de charges, et 0 signifie sans
-- limite, donc on peut cliquer autant de fois qu'on veut. Data2 (partyOnly) doit rester à 0, sinon
-- le cœur exige un propriétaire et refuse l'interaction ; Data3 évite de démonter le joueur.
DELETE FROM `gameobject_template` WHERE `entry` = 2600006;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`,
                                   `Data0`, `Data1`, `Data2`, `Data3`) VALUES
 (2600006, 22, 47602, 'Portail du Vide', 1, 0, 0, 0, 1);

DELETE FROM `gameobject` WHERE `id` = 2600006;
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681042, 2600006, 2678, 15010, 15010, 1, 1, '',
  -1767.38, -3471.81, 6238.96, 5.50523, 0, 0, SIN(5.50523/2), COS(5.50523/2),
  300, 0, 0, 1, 1, 0);
