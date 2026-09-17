-- La cloche est un objet de carte, donc type 33 et modèle lu dans DestructibleModelData ; les trois
-- autres sont des M2 et restent en type 5, où `size` atteint bien le client.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600038, 2600039, 2600040, 2600041);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600038, 33, 47631, 'Cloche de Bastion',       1, 1048608, 196, 1200, 1),
 (2600039,  5, 47632, 'Fleurs flottantes',       1,       0,   0,  800, 1),
 (2600040,  5, 47633, 'Fleurs flottantes II',    1,       0,   0,  800, 1),
 (2600041,  5, 47634, 'Arbre-cage de Bastion',   1,       0,   0, 1000, 1);
