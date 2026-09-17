-- A gameobject of type 33 does not display its own `displayId`: the client reads the record named
-- by `Data18` in DestructibleModelData and draws that record's State0WMO. Pointing our three WMO at
-- record 26, copied from Light's Point Tower, showed the guard tower instead of the void structure.
--
-- One record per model, State0WMO pointing at our own display, the other states left empty so the
-- object has no damaged or destroyed appearance. DoNotHighlight follows record 26: no outline when
-- the cursor passes over it.
--
-- Identifiers stay inside the [25, 241] range the 7.3.5 file declares, otherwise the record is
-- rejected. The table hash is the one in the DB2 file header, 0x7A74425D - not the layout hash
-- 0x1092C9AF that sits next to it in DB2Metadata.h, which the server does not recognise: a wrong
-- hash makes it drop the row silently and only the count in "Loaded N hotfix records" betrays it.
DELETE FROM `destructible_model_data` WHERE `ID` IN (238, 239, 240);
INSERT INTO `destructible_model_data` (`ID`, `State0Wmo`, `DoNotHighlight`, `VerifiedBuild`) VALUES
 (238, 47603, 1, 26972),   -- Tendril du Vide
 (239, 47604, 1, 26972),   -- Tendril du Vide II
 (240, 47607, 1, 26972);   -- Structure du Vide

DELETE FROM `hotfix_data` WHERE `Id` IN (9000504, 9000505, 9000506) AND `TableHash` = 2054439517;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000504, 2054439517, 238, 0, 0),
 (9000505, 2054439517, 239, 0, 0),
 (9000506, 2054439517, 240, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 102;
