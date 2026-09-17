-- The departure effect reads well facing the camera but stays too small: scale goes from 1 to 5.
--
-- The scale sits in the column named `BaseMissileSpeed` - `SpellVisualEffectName`'s names are
-- shifted in 7.3.5. Native records run from 0.15 to 8, so 5 stays inside what the client is used to.
UPDATE `spell_visual_effect_name` SET `BaseMissileSpeed` = 5 WHERE `ID` = 31936;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 149;
