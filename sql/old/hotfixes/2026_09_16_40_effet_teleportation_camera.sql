-- The departure effect had to cover the screen, and it stayed in front of the character.
--
-- A spell model is placed by `SpellVisualKitModelAttach`. Attachment 127 drops the bone and puts
-- the model on the unit itself, which is as close to the player as an attachment gets - but still
-- in the world. What moves a model onto the camera is `PositionerID`, and the value is 151.
--
-- Read straight out of the client data: every model whose name ends in `_camera` uses attachment
-- 127 together with positioner 151, and nothing else does. The list is short and unambiguous -
-- 7fx_valhallas_teleportdissolve_camera, 7fx_nightborn_timewarp_camera, 7fx_karazhan_teleport_camera,
-- fadetoblack_camera, cameravignette. Thirty-seven rows in the whole table carry positioner 151.
UPDATE `spell_visual_kit_model_attach` SET `PositionerID` = 151 WHERE `ID` = 362378;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 151;
