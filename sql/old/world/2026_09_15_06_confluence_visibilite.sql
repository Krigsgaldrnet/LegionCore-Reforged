-- Confluence temporelle: the custom gameobjects sit 8700 units above the terrain their grid was
-- built for, so the cell walk never reaches them. MaxVisible moves them to the map-wide list and
-- VisibilityDistance sets how far they are drawn; together with the grid preload added to
-- Map::Map they are loaded before the player gets near.
UPDATE `gameobject_template` SET `VisibilityDistance` = 800, `MaxVisible` = 1 WHERE `entry` = 2600003;
UPDATE `gameobject_template` SET `VisibilityDistance` = 800, `MaxVisible` = 1 WHERE `entry` = 2600005;
UPDATE `gameobject_template` SET `VisibilityDistance` = 800, `MaxVisible` = 1 WHERE `entry` IN (2600006, 2600007, 2600008);
UPDATE `gameobject_template` SET `VisibilityDistance` = 1200, `MaxVisible` = 1 WHERE `entry` IN (2600009, 2600010, 2600011);
