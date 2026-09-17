-- `.gob add` pose animprogress à 0. Sur les gameobjects natifs de type 5, la valeur courante est
-- 255 : 32 394 exemplaires contre 4 905 à zéro. Ce champ est l'octet d'animation de
-- GAMEOBJECT_BYTES_1 ; à zéro le client traite l'objet comme à 0 % et n'anime pas son modèle.
--
-- Les décors custom de la Confluence prennent donc 255, comme le reste du monde.
UPDATE `gameobject` g
  JOIN `gameobject_template` t ON t.`entry` = g.`id`
  SET g.`animprogress` = 255
  WHERE g.`id` BETWEEN 2600000 AND 2610000 AND t.`type` = 5 AND g.`animprogress` = 0;
