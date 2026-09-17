-- Le portail sans nom devient la sortie de la Confluence : retour à Dalaran, carte 1220.
--
-- Sort 259122, choisi comme le précédent : rattaché à un seul gabarit de portail que personne ne
-- pose, et sans destination — il ne téléportait donc nulle part. Le sort d'un gameobject de type 22
-- se met dans `Data0` ; `Data1` est le nombre de charges, -1 pour illimité.
DELETE FROM `spell_target_position` WHERE `id` = 259122;
INSERT INTO `spell_target_position`
 (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
 (259122, 1220, -1280.4, 4493.6, 657.3, 6.19);

UPDATE `gameobject_template` SET `Data0` = 259122, `Data1` = -1, `Data3` = 1 WHERE `entry` = 2600050;
