-- Portail vers la Confluence : échelle 0,5 et portée ramenée à 500. Les 5 000 servaient à le voir
-- depuis le large au-dessus de Dalaran ; à cette taille il n'a plus lieu d'être lu de si loin.
UPDATE `gameobject_template` SET `size` = 0.5, `VisibilityDistance` = 500 WHERE `entry` = 2600053;
