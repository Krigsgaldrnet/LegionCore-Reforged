-- ---------------------------------------------------------------------------------------------
-- Let the Arathi Basin loading screen use its widescreen slots.
--
-- LoadingScreens 183 is the screen map 529 asks for, and both battlegrounds hosted on that map
-- get it. Blizzard only ever filled its narrow slot, so a client on a wide display squeezes the
-- image into 4:3. Filling all three was not enough: the client prefers the narrow slot whenever it is set,
-- so this leaves the first two at zero, exactly as every 16:9 screen Blizzard ships does.
--
-- The file behind 131820 is served by CASCHost, so only the record needs a hotfix here.
-- TableHash 2579557240 is LoadingScreens (0x99C0EB78).
-- ---------------------------------------------------------------------------------------------

DELETE FROM `loading_screens` WHERE `ID` = 183;
INSERT INTO `loading_screens` (`ID`, `NarrowScreenFileDataID`, `WideScreenFileDataID`, `WideScreen169FileDataID`, `VerifiedBuild`) VALUES
(183, 0, 0, 131820, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000317;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000317, 2579557240, 183, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 28;
