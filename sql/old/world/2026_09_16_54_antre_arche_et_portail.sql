-- The Maw entrance splits in two: 2600005 keeps the spot and becomes the arch, plain decor with no
-- interaction, and a new entry carries the portal itself, to be placed inside the arch.
--
-- The portal stays sealed - type 22 with no spell in Data0 - until the tier that opens the Antre
-- ships, the same shape as the Emerald Dream and Bastion portals.
UPDATE `gameobject_template`
 SET `type` = 5,
     `displayId` = 47658,
     `name` = 'Arche de l''Antre',
     `size` = 1,
     `Data0` = 0,
     `Data1` = 0,
     `Data3` = 0,
     `VisibilityDistance` = 5000
 WHERE `entry` = 2600005;

DELETE FROM `gameobject_template` WHERE `entry` = 2600065;
INSERT INTO `gameobject_template`
 (`entry`, `type`, `displayId`, `name`, `size`, `flags`, `Data0`, `Data1`, `Data3`, `Data18`,
  `VisibilityDistance`, `MaxVisible`) VALUES
 (2600065, 22, 47657, 'Portail vers l''Antre', 1.5, 0, 0, 0, 1, 0, 5000, 1);
