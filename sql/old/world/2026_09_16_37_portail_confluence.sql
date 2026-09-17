-- Le portail d'entrée vers la Confluence. Il sera posé à Dalaran, donc une portée large : à 1 200 le
-- pavillon dracthyr disparaissait dès qu'on s'éloignait de la cité.
--
-- Type 22, celui où le clic lance un sort. `Data1` reste à 0 jusqu'à ce que le sort de téléportation
-- existe ; `Data3` à 1 autorise le clic monté.
DELETE FROM `gameobject_template` WHERE `entry` = 2600053;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data1`, `Data3`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600053, 22, 47645, 'Portail vers la Confluence temporelle', 1, 0, 0, 1, 5000, 1);
