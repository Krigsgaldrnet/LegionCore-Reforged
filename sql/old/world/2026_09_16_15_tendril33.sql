-- Type 33, seul type où le client accepte de dessiner un objet de carte.
DELETE FROM `gameobject_template` WHERE `entry` = 2600037;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600037, 33, 47630, 'Tendril du Vide VIII', 1, 1048608, 197, 1200, 1);
