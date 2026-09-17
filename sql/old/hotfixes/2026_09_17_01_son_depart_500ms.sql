-- Departure sound moves from 0.3 s to 0.5 s behind the effect.
--
-- The delay lives on the kit, not on the effect row, which is why the sound sits alone in 94939.
UPDATE `spell_visual_kit` SET `DelayMin` = 500, `DelayMax` = 500 WHERE `ID` = 94939;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 154;
