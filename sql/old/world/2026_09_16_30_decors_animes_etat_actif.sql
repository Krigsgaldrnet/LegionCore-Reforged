-- Vérifié en jeu : `.gob set state <guid> 0 0` fait tourner l'animation en boucle. C'est l'état du
-- gameobject, et lui seul, qui décide de la séquence que le client joue — GO_STATE_ACTIVE (0) la
-- lance, GO_STATE_READY (1) la laisse figée. `.gob add` pose toujours 1.
--
-- Les six modèles de Bastion portent tous une séquence d'identifiant 0, la Stand, donc tous
-- répondent à ce levier. Le passage est appliqué à tous les décors custom de type 5.
UPDATE `gameobject` g
  JOIN `gameobject_template` t ON t.`entry` = g.`id`
  SET g.`state` = 0
  WHERE g.`id` BETWEEN 2600000 AND 2610000 AND t.`type` = 5;
