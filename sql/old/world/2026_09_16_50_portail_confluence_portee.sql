-- Le portail vers la Confluence est posé à Dalaran, comme le pavillon : à 500 il disparaît dès
-- qu'on s'écarte. La portée décide de la distance à laquelle le serveur cesse de l'envoyer, pas de
-- la taille à laquelle il s'affiche — la réduire n'a aucun rapport avec l'échelle 0,5.
UPDATE `gameobject_template` SET `VisibilityDistance` = 5000 WHERE `entry` = 2600053;
