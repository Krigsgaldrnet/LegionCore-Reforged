-- Le portail du Rêve d'Émeraude existait déjà : l'exemplaire 25681036, une « Porte temporelle »
-- parmi quatorze. Lui donner son nom demande une entrée à lui, sinon renommer le gabarit
-- renommerait les treize autres.
--
-- Il garde son modèle actuel, la porte temporelle (affichage 47689) : c'est déjà la bonne image,
-- rien ne justifie de la changer. Il passe en type 22, celui où le clic lance un sort, avec
-- `Data1` à 0 tant que la destination n'existe pas.
UPDATE `gameobject_template` SET `displayId` = 47689, `size` = 1 WHERE `entry` = 2600049;

UPDATE `gameobject` SET `id` = 2600049 WHERE `guid` = 25681036;

-- Le modèle rayonnant importé pour les portails reste disponible sous sa propre entrée.
DELETE FROM `gameobject_template` WHERE `entry` = 2600050;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data1`, `Data3`, `VisibilityDistance`, `MaxVisible`) VALUES
 (2600050, 22, 47642, 'Portail des Voies du temps', 1, 0, 0, 1, 800, 1);
