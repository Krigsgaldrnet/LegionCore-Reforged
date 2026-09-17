-- Each WMO gameobject points at its own DestructibleModelData record, created in the hotfixes
-- update of the same day. Record 26, borrowed from Light's Point Tower to get type 33 working,
-- carried that tower's own model and was drawn instead of ours.
UPDATE `gameobject_template` SET `Data18` = 238 WHERE `entry` = 2600009;
UPDATE `gameobject_template` SET `Data18` = 239 WHERE `entry` = 2600010;
UPDATE `gameobject_template` SET `Data18` = 240 WHERE `entry` = 2600011;
