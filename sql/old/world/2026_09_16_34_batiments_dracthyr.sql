-- Type 33, seul type où le client accepte de dessiner un objet de carte, et où il lit son modèle
-- dans DestructibleModelData plutôt que dans `displayId`.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600051, 2600052);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600051, 33, 47643, 'Pavillon dracthyr', 1, 1048608, 195, 1200, 1),
 (2600052, 33, 47644, 'Sanctuaire dracthyr', 1, 1048608, 194, 1200, 1);
