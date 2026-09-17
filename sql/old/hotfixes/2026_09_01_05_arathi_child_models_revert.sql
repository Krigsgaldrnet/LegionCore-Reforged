-- ---------------------------------------------------------------------------------------------
-- Drop the child model hotfix: the swap is done by file replacement instead.
--
-- CreatureModelData 79, 80 and 2972 keep pointing at 124495 / 124456, and those two files are now
-- served with the Arathi child models through CASCHost. The six texture variations the display
-- records name are served the same way, so each NPC keeps its own variant.
--
-- Nothing in the client's tables is touched any more, which is the point: CreatureModelData.SoundID
-- and every CreatureDisplayInfo.NPCSoundID / SoundID stay exactly as shipped. A hotfix row replaces
-- the whole record, so leaving one behind meant one mistyped field away from losing the sounds -
-- which is how the first attempt broke them.
-- ---------------------------------------------------------------------------------------------

DELETE FROM `creature_model_data` WHERE `ID` IN (79, 80, 2972);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000321 AND 9000323;

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 30;
