-- Un M2, donc type 5 : le modèle vient de `displayId` et `size` atteint le client.
DELETE FROM `gameobject_template` WHERE `entry` = 2600047;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600047, 5, 47640, 'Statue du temple', 1, 0, 0, 1000, 1);
