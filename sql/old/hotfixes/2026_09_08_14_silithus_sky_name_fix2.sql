-- The name repair needed a backslash that survives every layer.
--
-- Update 13 wrote the paths with doubled backslashes and they still landed collapsed: the file
-- reached disk with single ones, so MySQL ate them exactly as it had the first time. Reading the
-- table afterwards is what caught it - 904 and 905 were unchanged.
--
-- CHAR(92) is a backslash no quoting layer can touch, so the value cannot be mangled again on the
-- way in. Verify with SELECT: the name must read Environments\Stars\<model>.m2 - two separators.
UPDATE `light_skybox` SET `Name` = CONCAT('Environments', CHAR(92), 'Stars', CHAR(92), '8dru_sky01.m2')        WHERE `ID` = 901;
UPDATE `light_skybox` SET `Name` = CONCAT('Environments', CHAR(92), 'Stars', CHAR(92), '10xp_timewaysky01.m2') WHERE `ID` = 904;
UPDATE `light_skybox` SET `Name` = CONCAT('Environments', CHAR(92), 'Stars', CHAR(92), '9cas_sky01.m2')        WHERE `ID` = 905;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 54;
