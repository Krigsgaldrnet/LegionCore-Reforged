-- Une troisième taille pour le Trou noir du Vide. C'est un M2 : `size` l'atteint, donc une simple
-- entrée de plus sur le même affichage suffit, sans toucher au fichier.
DELETE FROM `gameobject_template` WHERE `entry` = 2600033;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600033, 5, 47609, 'Trou noir du Vide (petit)', 0.6, 800, 1);
