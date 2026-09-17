-- Type 33, seul type où le client accepte de dessiner un objet de carte, et où il lit son modèle
-- dans DestructibleModelData plutôt que dans `displayId`.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600034, 2600035, 2600036);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600034, 33, 47627, 'Tendril du Vide V', 1, 1048608, 231, 1200, 1),
 (2600035, 33, 47628, 'Tendril du Vide VI', 1, 1048608, 227, 1200, 1),
 (2600036, 33, 47629, 'Tendril du Vide VII', 1, 1048608, 225, 1200, 1);
