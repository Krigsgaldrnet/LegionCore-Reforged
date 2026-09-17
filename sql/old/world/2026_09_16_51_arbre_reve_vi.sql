-- Same settings as the other dream trees: `VisibilityDistance` replaces `MaxVisible` instead of
-- adding to it, so it has to be far enough on its own.
DELETE FROM `gameobject_template` WHERE `entry` = 2600064;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600064, 5, 47656, 'Arbre du Rêve VI', 1, 0, 0, 5000, 1);
