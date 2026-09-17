-- Sphère du Vide : modèle M2, donc type 5. Le type 33 n'est nécessaire que pour un WMO, dont
-- l'affichage passe par DestructibleModelData.
--
-- Deux entrées sur le même affichage : l'échelle est une propriété du modèle, pas de la commande,
-- donc une taille différente demande une entrée de plus.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600012, 2600013);
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600012, 5, 47608, 'Sphère du Vide',          1, 500, 1),
 (2600013, 5, 47608, 'Sphère du Vide (grande)', 2, 500, 1);
