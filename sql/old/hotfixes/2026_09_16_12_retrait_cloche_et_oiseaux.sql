-- Affichages de la cloche de Bastion et de l'envol d'oiseaux, retirés avec leurs gameobjects.
-- L'enregistrement destructible 196 ne servait qu'à la cloche : un objet de carte lit son modèle
-- là, pas dans `displayId`.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47631, 47638);
DELETE FROM `destructible_model_data` WHERE `ID` = 196;
DELETE FROM `hotfix_data` WHERE `Id` IN (9000539, 9000540, 9000547);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 123;
