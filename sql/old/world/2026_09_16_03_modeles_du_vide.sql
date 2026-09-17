-- Les douze M2 passent en type 5. Les trois WMO en type 33 : c'est le seul type où le client
-- accepte de dessiner un objet de carte, et il y lit son modèle dans DestructibleModelData.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600016,2600017,2600018,2600019,2600020,2600021,2600022,2600023,2600024,2600025,2600026,2600027,2600028,2600029,2600030);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600016, 5, 47610, 'Pylône du Vide', 1, 0, 0, 800, 1),
 (2600017, 5, 47611, 'Pylône flottant', 1, 0, 0, 800, 1),
 (2600018, 5, 47612, 'Petite lumière du Vide', 1, 0, 0, 800, 1),
 (2600019, 5, 47613, 'Éclat flottant', 1, 0, 0, 800, 1),
 (2600020, 5, 47614, 'Outil du Vide', 1, 0, 0, 800, 1),
 (2600021, 5, 47615, 'Cristal d''invocation', 1, 0, 0, 800, 1),
 (2600022, 5, 47616, 'Armoire de canalisation', 1, 0, 0, 800, 1),
 (2600023, 5, 47617, 'Coffre du Vide', 1, 0, 0, 800, 1),
 (2600024, 5, 47618, 'Bannière du Vide', 1, 0, 0, 800, 1),
 (2600025, 5, 47619, 'Lanterne suspendue', 1, 0, 0, 800, 1),
 (2600026, 5, 47620, 'Dépouille de marcheur', 1, 0, 0, 800, 1),
 (2600027, 5, 47621, 'Dépouille de spectre', 1, 0, 0, 800, 1),
 (2600028, 33, 47622, 'Kiosque du Vide', 1, 1048608, 235, 1200, 1),
 (2600029, 33, 47623, 'Entrée du raid du Vide', 1, 1048608, 236, 1200, 1),
 (2600030, 33, 47624, 'Arche du Vide', 1, 1048608, 237, 1200, 1);
