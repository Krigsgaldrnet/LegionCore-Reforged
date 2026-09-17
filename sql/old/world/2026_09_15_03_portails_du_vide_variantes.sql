-- Les trois portails du Vide. 2600007 et 2600008 reprennent les entrees des tendrils, qui n'avaient
-- pas d'apparition en jeu.
--
-- type 22 (SPELLCASTER), celui des portails de Blizzard : Data0 recevra le sort de teleportation,
-- Data1 a 0 signifie un nombre de charges illimite, donc cliquable sans fin.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600006, 2600007, 2600008);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`,
                                   `Data0`, `Data1`, `Data2`, `Data3`) VALUES
 (2600006, 22, 47602, 'Portail du Vide', 1.5, 0, 0, 0, 1),
 (2600007, 22, 47605, 'Portail du Vide', 1.5, 0, 0, 0, 1),
 (2600008, 22, 47606, 'Portail du Vide', 1.5, 0, 0, 0, 1);
