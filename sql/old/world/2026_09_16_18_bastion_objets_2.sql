-- Des M2, donc type 5 : `size` atteint le client et le modèle vient de `displayId`.
--
-- L'hélice fait 630 m de haut : sa portée doit suivre, sinon elle disparaît bien avant d'être
-- sortie du champ. MaxVisible est ce qui la sort du parcours des grilles.
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 2600042 AND 2600046;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600042, 5, 47635, 'Dérivateur d''anima',            1, 0, 0,  800, 1),
 (2600043, 5, 47636, 'Grand cercle runique',           1, 0, 0, 1200, 1),
 (2600044, 5, 47637, 'Hélice du temple des mémoires',  1, 0, 0, 4000, 1),
 (2600045, 5, 47638, 'Envol d''oiseaux',               1, 0, 0, 1000, 1),
 (2600046, 5, 47639, 'Statue de kyrian',               1, 0, 0, 1000, 1);
