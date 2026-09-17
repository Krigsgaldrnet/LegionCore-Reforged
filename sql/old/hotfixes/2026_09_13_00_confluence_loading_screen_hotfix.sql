-- The loading screen of map 2678 never reached the client: loading_screens carried its row, but
-- hotfix_data - the table that decides what the server actually sends - only listed record 183,
-- the Arathi Basin screen. Without its own entry the client never learns the row exists and falls
-- back to the default screen.
--
-- The narrow and wide slots are cleared at the same time. A client shown a filled narrow slot
-- prefers it and stretches it to 4:3; Blizzard's own 16:9 screens leave both at zero.
UPDATE `loading_screens`
   SET `NarrowScreenFileDataID` = 0,
       `WideScreenFileDataID` = 0
 WHERE `ID` = 2678;

DELETE FROM `hotfix_data` WHERE `Id` = 9000487 AND `TableHash` = 2579557240;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000487, 2579557240, 2678, 0, 0);

-- The cache id lives in the world database, not here; raise it there so the client re-asks for
-- its hotfixes instead of trusting the copy it already has.

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 86;
