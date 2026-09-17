-- The skybox names lost their backslashes.
--
-- 'Environments\Stars\10xp_timewaysky01.m2' written with single backslashes is read by MySQL as an
-- escape: \S is S and \1 is 1, so what landed in the table was EnvironmentsStars10xp... Records 901,
-- 904 and 905 all carry a mangled path; 902 and 903, written with doubled backslashes, are intact -
-- and those two are precisely the ones that ever showed a sky.
--
-- LightSkybox in 7.3.5 carries both a name and a SkyboxFileDataID, and which of the two the client
-- prefers is not documented. Repairing the name removes the question.
UPDATE `light_skybox` SET `Name` = 'Environments\Stars\8dru_sky01.m2'          WHERE `ID` = 901;
UPDATE `light_skybox` SET `Name` = 'Environments\Stars\10xp_timewaysky01.m2'   WHERE `ID` = 904;
UPDATE `light_skybox` SET `Name` = 'Environments\Stars\9cas_sky01.m2'          WHERE `ID` = 905;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 53;
