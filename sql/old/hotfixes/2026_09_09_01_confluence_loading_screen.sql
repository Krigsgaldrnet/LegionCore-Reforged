-- Loading screen for map 2678.
--
-- The map was pointed at Argus's screen (432) only so it would have one at all. This gives it its
-- own: Blizzard's own art for the Dawn of the Infinite, served under its real path so nothing has
-- to be renamed.
--
-- LoadingScreens.db2 names its images by FileDataID, never by path, so the row has to carry the id
-- CASCHost handed the file when it entered the root - read back from caschost.root_entries rather
-- than assumed. The same id fills the three slots: there is one image, and the client picks a slot
-- by aspect ratio.
--
-- ID 2678 matches the map. LoadingScreens.db2 stops at 436, so nothing collides.
--
-- TableHash 4020094719 LoadingScreens, 3179597154 Map.

DELETE FROM `loading_screens` WHERE `ID` = 2678;
INSERT INTO `loading_screens` (`ID`, `NarrowScreenFileDataID`, `WideScreenFileDataID`,
                               `WideScreen169FileDataID`, `VerifiedBuild`) VALUES
(2678, 8000450, 8000450, 8000450, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000481;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000481, 4020094719, 2678, 0, 0);

UPDATE `map` SET `LoadingScreenID` = 2678 WHERE `ID` = 2678;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 68;
