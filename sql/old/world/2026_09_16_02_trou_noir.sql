-- Trou noir du Vide : modèle M2, type 5. Une entrée par échelle, l'échelle étant une propriété
-- de l'entrée et non de la commande.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600014, 2600015);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600014, 5, 47609, 'Trou noir du Vide',          1, 800, 1),
 (2600015, 5, 47609, 'Trou noir du Vide (grand)',  2, 800, 1);
