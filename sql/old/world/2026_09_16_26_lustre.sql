-- Un M2, donc type 5. Le modèle commence à 3,39 au-dessus de son origine : il est fait pour pendre
-- d'un plafond, il faudra le poser en hauteur.
DELETE FROM `gameobject_template` WHERE `entry` = 2600048;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600048, 5, 47641, 'Lustre de Bastion', 1, 0, 0, 800, 1);
