-- Rendre le portail vers la Confluence fonctionnel.
--
-- Correction au passage : pour un gameobject de type 22, **le sort est `Data0`**, pas `Data1` —
-- `Data1` porte le nombre de charges. Les entrées créées cette nuit avaient le sort au mauvais
-- endroit, ce qui n'avait aucun effet puisqu'il valait 0.
--
-- Le sort employé est 259125, déjà rattaché à deux gabarits de portail que personne ne pose et qui
-- n'ont aucune destination : il téléporte donc vers nulle part aujourd'hui. Lui en donner une ne
-- peut rien casser. `Spell::EffectTeleportUnits` lit `spell_target_position` par identifiant de
-- sort, à condition que la cible de l'effet soit le lanceur seul.
DELETE FROM `spell_target_position` WHERE `id` = 259125;
INSERT INTO `spell_target_position`
 (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
 (259125, 2678, -1751.5, -3268.7, 6217.4, 4.51);

UPDATE `gameobject_template` SET `Data0` = 259125, `Data1` = -1, `Data3` = 1 WHERE `entry` = 2600053;
