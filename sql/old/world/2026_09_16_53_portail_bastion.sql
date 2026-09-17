-- The anima diverter standing on the Bastion platform becomes its portal.
--
-- Type 22 with no spell in Data0 is what a sealed portal looks like here: it is there to be seen
-- and clicked, and stays silent until the tier that opens the Bastion d'Éternité ships. Same shape
-- as 2600049, the Emerald Dream portal.
--
-- The range goes to 5000 : the Bastion platform is about 1450 yards from the central one, so at 800
-- the portal was invisible from where a player is meant to spot it. As everywhere else,
-- `VisibilityDistance` replaces `MaxVisible` instead of adding to it.
UPDATE `gameobject_template`
 SET `type` = 22,
     `name` = 'Portail vers le Bastion d''Éternité',
     `Data0` = 0,
     `Data1` = 0,
     `Data3` = 1,
     `VisibilityDistance` = 5000
 WHERE `entry` = 2600042;

-- State 0 is what plays the loop; the model's slot 0 now carries its "Opened" animation.
UPDATE `gameobject` SET `state` = 0, `animprogress` = 255 WHERE `id` = 2600042;
