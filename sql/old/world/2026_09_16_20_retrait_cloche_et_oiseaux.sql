-- La cloche de Bastion et l'envol d'oiseaux ne seront pas utilisés.
DELETE FROM `gameobject` WHERE `id` = 2600045;
DELETE FROM `gameobject_template` WHERE `entry` IN (2600038, 2600045);
