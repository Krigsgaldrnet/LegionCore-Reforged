-- Même piège que les arbres : les entrées sonores désignaient l'identifiant du listfile, alors que
-- CASCHost a attribué aux quatre fichiers des identifiants 8004172 à 8004175 lors de la
-- reconstruction. La réservation écrite avant l'assemblage ne survit pas au renumérotage.
--
-- Identifiants relus dans `root_entries`, jamais supposés.
UPDATE `sound_kit_entry` SET `FileDataID` = 8004174 WHERE `ID` = 252954;  -- go_10du_infinitedungeon_timegate01_loop_4558593.ogg
UPDATE `sound_kit_entry` SET `FileDataID` = 8004173 WHERE `ID` = 252953;  -- go_10du_infinitedungeon_timegate01_loop_4558595.ogg
UPDATE `sound_kit_entry` SET `FileDataID` = 8004175 WHERE `ID` = 252952;  -- go_10du_infinitedungeon_timegate01_loop_4558597.ogg
UPDATE `sound_kit_entry` SET `FileDataID` = 8004172 WHERE `ID` = 252951;  -- go_fx_teleport_aura_oneshot_4565285.ogg

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 136;
