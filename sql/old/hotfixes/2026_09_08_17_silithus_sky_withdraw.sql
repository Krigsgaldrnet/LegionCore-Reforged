-- Everything I fabricated for this sky is withdrawn.
--
-- The cloned LightData of update 16. The project notes say it plainly, from three failed attempts
-- on 2026-08-31: LightData rows must never be cloned. They read back correctly on the server and
-- arrive unusable at the client, which then falls back to a default lighting - fog and no sky,
-- exactly what was on screen. I wrote update 16 without checking that note.
--
-- LightParams 3706 and 3707, which existed only to carry that palette. A parameter set with no
-- LightData has no colours at all, which is the same failure by another road.
--
-- Light 9001, the record I created. The next update puts the sky back where it worked.
--
-- Nothing is added here on purpose: the same notes warn that marking rows Deleted while inserting
-- other ids in the same file confuses the client. Withdrawals go alone.
--
-- TableHash 181829311 LightData, 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_data` WHERE `LightParamID` IN (3706, 3707);
DELETE FROM `light_params` WHERE `ID` IN (3706, 3707);
DELETE FROM `light` WHERE `ID` = 9001;

UPDATE `hotfix_data` SET `Deleted` = 1
WHERE `Id` IN (9000451, 9000452, 9000453, 9000448, 9000442);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 57;
