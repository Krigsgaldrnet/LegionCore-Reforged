-- The Icecrown sky is withdrawn.
--
-- Its fourteen files - the model, its skin and its twelve textures - are deleted from what CASCHost
-- serves, so the record would point at nothing. They were checked against the backup repository
-- before deletion and are recoverable from it, and no other served model referenced any of those
-- textures.
--
-- Nothing is added here: marking rows Deleted while inserting other ids in the same file confuses
-- the client, so withdrawals go alone.
--
-- TableHash 3546600791 LightSkybox.

DELETE FROM `light_skybox` WHERE `ID` = 903;

UPDATE `hotfix_data` SET `Deleted` = 1 WHERE `Id` = 9000441;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 60;
