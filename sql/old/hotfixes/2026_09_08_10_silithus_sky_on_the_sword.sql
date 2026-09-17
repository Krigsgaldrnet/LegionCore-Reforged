-- The broken sky belongs over the sword, not over the whole map.
--
-- The first attempt made it the default light of map 1817, so it covered everything. What is
-- wanted is a sky that comes up as you approach the wound. A Light record is exactly that: a
-- position and a falloff, blended with whatever else reaches the point.
--
-- Where the sword is was measured, not guessed: the 773 creatures that carry phase 10277, the
-- Wound, sit between x -8084 and -6172 and y -321 and 1938, centred on -7093 / 802. The light goes
-- there, 500 in and 800 out, so the sky is solid over the crater and fades on the way in.
--
-- The three lights the map already had go back to the parameters they were born with. Repointing
-- them was what made the sky appear next to Zidormi and nowhere else - 9151 sits 60 yards from
-- her, with a reach of 196.
DELETE FROM `light` WHERE `ID` IN (9000, 9320, 9150, 9151, 9152, 9001);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9001, -7093,   802, 100, 500,  800, 1817, 3706,   11, 3706,   11, 3, 0, 0, 0, 0),
(9150, -6158,  3473,   0, 897, 1334, 1817,  254,  207,  425,  207, 3, 0, 0, 0, 0),
(9151, -6419,  -233,   0, 196,  306, 1817,  253,  207,  408,  207, 3, 0, 0, 0, 0),
(9152, -8401,  -209, 200, 221,  322, 1817, 1000,  946, 1002,   11, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000443, 9000447, 9000448);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000443, 1556783290, 9320, 0, 1),
(9000447, 1556783290, 9000, 0, 1),
(9000448, 1556783290, 9001, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 50;
