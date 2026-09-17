-- Huit des neuf arbres sortaient en cube : leur affichage désignait l'identifiant du listfile,
-- alors que CASCHost en sert un autre.
--
-- Ces chemins étaient déjà connus de `root_entries` par un import précédent, avec un identifiant
-- 800xxxx attribué à l'époque ; la réservation de l'import n'a pas écrasé la ligne existante. Seul
-- `10xp_tree82` avait gardé le sien.
--
-- La règle, déjà apprise sur les racines de WMO et qui vaut donc aussi pour les M2 : **relire
-- l'identifiant dans `root_entries` après la reconstruction**, jamais le supposer.
UPDATE `gameobject_display_info` SET `FileDataID` = 4025193 WHERE `ID` = 47647;  -- 10xp_tree82
UPDATE `gameobject_display_info` SET `FileDataID` = 8001136 WHERE `ID` = 47648;  -- 10xp_tree83
UPDATE `gameobject_display_info` SET `FileDataID` = 8002394 WHERE `ID` = 47649;  -- 10xp_tree84
UPDATE `gameobject_display_info` SET `FileDataID` = 8001790 WHERE `ID` = 47650;  -- 10xp_tree85
UPDATE `gameobject_display_info` SET `FileDataID` = 8002323 WHERE `ID` = 47651;  -- 10xp_tree86
UPDATE `gameobject_display_info` SET `FileDataID` = 8000852 WHERE `ID` = 47652;  -- 10xp_tree87
UPDATE `gameobject_display_info` SET `FileDataID` = 8001975 WHERE `ID` = 47653;  -- 10xp_treetrunk01
UPDATE `gameobject_display_info` SET `FileDataID` = 8001315 WHERE `ID` = 47654;  -- 10xp_treetrunk02
UPDATE `gameobject_display_info` SET `FileDataID` = 8001709 WHERE `ID` = 47655;  -- 10xp_treetrunk03

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 135;
