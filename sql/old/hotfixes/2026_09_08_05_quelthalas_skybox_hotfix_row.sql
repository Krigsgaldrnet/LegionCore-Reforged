-- The skybox record itself was never announced to the client.
--
-- 2026_09_08_01 created light_skybox 902 and pointed three LightParams at it, but only the
-- LightParams got hotfix_data rows. A hotfix the client is not told about is not sent, so 399 kept
-- pointing at a record the client did not have and no skybox was drawn - while the other fields of
-- those same LightParams did arrive, which is why the sky looked changed without ever showing the
-- model. The client's Hotfix.log listed LightSkybox 901, Drustvar's, and nothing else.
--
-- TableHash 3546600791 is LightSkybox.
DELETE FROM `hotfix_data` WHERE `Id` = 9000439;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000439, 3546600791, 902, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 45;
