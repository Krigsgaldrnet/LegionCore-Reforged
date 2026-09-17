-- Premier portail nommé de la plateforme principale.
--
-- Type 22, comme les portails déjà en place : c'est celui où le clic lance un sort. `Data1` porte
-- ce sort et reste à 0 tant que la destination n'existe pas — le portail se voit et se survole,
-- mais ne fait rien. `Data3` à 1 autorise le clic monté.
DELETE FROM `gameobject_template` WHERE `entry` = 2600049;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data1`, `Data3`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600049, 22, 47642, 'Portail vers le Rêve d''Émeraude', 1, 0, 0, 1, 800, 1);
