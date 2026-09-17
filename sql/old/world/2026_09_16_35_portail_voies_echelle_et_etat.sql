-- Échelle 3 pour le portail des Voies du temps.
UPDATE `gameobject_template` SET `size` = 3 WHERE `entry` = 2600050;

-- Les exemplaires posés après la normalisation précédente reviennent à l'état 1 et animprogress 0,
-- puisque `.gob add` écrit toujours ces deux valeurs. On repasse tout le décor custom de type 5 et
-- les portails de type 22 en état actif : c'est lui qui fait jouer la séquence Stand en boucle.
UPDATE `gameobject` g
  JOIN `gameobject_template` t ON t.`entry` = g.`id`
  SET g.`state` = 0, g.`animprogress` = 255
  WHERE g.`id` BETWEEN 2600000 AND 2610000 AND t.`type` IN (5, 22);
