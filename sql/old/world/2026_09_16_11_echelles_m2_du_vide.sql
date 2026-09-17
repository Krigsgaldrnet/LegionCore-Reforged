-- Both of these display an M2, where the template's `size` does reach the client, so the scale is a
-- column change and the file is left alone. A WMO shown through a type 33 would need the geometry
-- itself rescaled.
UPDATE `gameobject_template` SET `size` = 0.5 WHERE `entry` = 2600033;
UPDATE `gameobject_template` SET `size` = 3   WHERE `entry` = 2600019;
