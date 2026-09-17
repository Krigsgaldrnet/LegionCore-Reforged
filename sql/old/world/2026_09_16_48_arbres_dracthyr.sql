-- Des M2, donc type 5 : `size` atteint le client et le modèle vient de `displayId`. Portée à
-- 1 500 : ces arbres montent jusqu'à 67 m, on doit les voir de loin.
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 2600055 AND 2600063;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600055, 5, 47647, 'Grand arbre du Rêve', 1, 0, 0, 1500, 1),
 (2600056, 5, 47648, 'Arbre du Rêve I', 1, 0, 0, 1500, 1),
 (2600057, 5, 47649, 'Arbre du Rêve II', 1, 0, 0, 1500, 1),
 (2600058, 5, 47650, 'Arbre du Rêve III', 1, 0, 0, 1500, 1),
 (2600059, 5, 47651, 'Arbre du Rêve IV', 1, 0, 0, 1500, 1),
 (2600060, 5, 47652, 'Arbre du Rêve V', 1, 0, 0, 1500, 1),
 (2600061, 5, 47653, 'Tronc du Rêve I', 1, 0, 0, 1500, 1),
 (2600062, 5, 47654, 'Tronc du Rêve II', 1, 0, 0, 1500, 1),
 (2600063, 5, 47655, 'Tronc du Rêve III', 1, 0, 0, 1500, 1);
