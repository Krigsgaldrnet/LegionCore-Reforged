-- ---------------------------------------------------------------------------------------------
-- Move the Arathi Basin starting positions.
--
-- battleground_template points both the original battleground and Azerite Rush at WorldSafeLocs
-- 889 and 890, so both modes start their teams from these two records.
--
-- TableHash 1616816294 is WorldSafeLocs (0x605EA8A6).
-- ---------------------------------------------------------------------------------------------

DELETE FROM `world_safe_locs` WHERE `ID` IN (889, 890);
INSERT INTO `world_safe_locs` (`ID`, `Name`, `LocX`, `LocY`, `LocZ`, `LocO`, `MapID`, `VerifiedBuild`) VALUES
(889, '', 695.3, 691.9, -11.6, 0.87, 529, 26972),
(890, '', 1301.8, 1301.6, -7.7, 3.92, 529, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000318, 9000319);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000318, 1616816294, 889, 0, 0),
(9000319, 1616816294, 890, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 25;
