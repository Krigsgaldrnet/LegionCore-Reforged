-- `ObjectMgr::LoadGameobjects` supprime, à chaque démarrage, tout spawn d'une **même entrée** posé à
-- moins de racine(0,5) ≈ 0,71 yard du précédent — un vrai `DELETE FROM gameobject`, pas un saut.
-- Trois exemplaires de l'hélice y sont passés, chaque fois à une distance de 0,000000 : `.gob add`
-- pose à la position du joueur, et deux ajouts sans bouger tombent au même endroit.
--
-- Une entrée jumelle contourne la règle proprement, puisque le contrôle porte sur l'entrée : elle
-- partage l'affichage 47637, donc le même modèle et la même boîte.
DELETE FROM `gameobject_template` WHERE `entry` = 2600054;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data18`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600054, 5, 47637, 'Hélice du temple des mémoires II', 1, 0, 0, 4000, 1);
