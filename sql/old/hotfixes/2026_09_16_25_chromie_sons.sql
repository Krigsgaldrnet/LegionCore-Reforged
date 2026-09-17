-- Chromie n'avait aucun son : `NPCSoundID` et `SoundID` à 0 sur son affichage.
--
-- Les valeurs sont reprises de l'affichage natif 10008, la Chromie du Puits du Soleil : `NPCSoundID`
-- 899, son jeu de répliques — salutations, adieux —, et `SoundID` 4735 pour les bruits de créature.
-- Rien n'est inventé, ce sont les siens.
UPDATE `creature_display_info` SET `NPCSoundID` = 899, `SoundID` = 4735 WHERE `ID` = 83273;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 137;
