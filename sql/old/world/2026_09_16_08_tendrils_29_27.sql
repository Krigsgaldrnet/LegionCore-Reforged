-- Type 33, seul type où le client accepte de dessiner un objet de carte, et où il lit son modèle
-- dans DestructibleModelData.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600031, 2600032);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600031, 33, 47625, 'Tendril du Vide III', 1, 1048608, 233, 1200, 1),
 (2600032, 33, 47626, 'Tendril du Vide IV', 1, 1048608, 234, 1200, 1);
