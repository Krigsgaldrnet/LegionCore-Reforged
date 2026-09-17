-- ==========================================================================================
-- Make the Quel'Thalas sky cover the zone, not just its southern half.
--
-- The first pass repointed the parameters of the twelve lights the zone already owned, and I wrote
-- that light 443, reach 2028, covered its heart. That was wrong: its coordinates put it in row 20
-- of 11-23, which is Ghostlands. Measured at falloffStart, where the sky is pure, the result was
--
--   Ghostlands       87.5 % covered
--   Eversong Woods    7.8 %
--   Silvermoon City   1.4 %
--
-- Eversong sits in rows 11 to 16 and had only three lights of 177 to 287 reach; everything else
-- fell back on map 530's default light, whose parameters are shared with the whole of Outland.
-- Editing those would give Hellfire and Nagrand the Elwynn sky, so local lights are added instead -
-- the same answer Elwynn and Stormwind needed, for the same reason.
--
-- The eight centres are not guesses. Every map chunk of Eversong and Silvermoon was read from the
-- MCNK headers, then circles of 800 reach were placed greedily on the chunks still uncovered:
--
--   1793 chunks, 1244, 803, 645, 357, 38, 14, 1  ->  4895 of 4895, 100 % at falloffStart
--
-- What they overrun is the North Sea around the coast, which wants the same sky, and Ghostlands,
-- which already carries it. Outland proper is tiles away and is not touched.
--
-- Parameters are the ones light 443 already uses - 399 clear, 383 underwater, 3 death - so these
-- lights bring the sky and change nothing else. 399 already points at skybox 902.
--
-- TableHash 1556783290 is Light.
-- ==========================================================================================

DELETE FROM `light` WHERE `ID` BETWEEN 9310 AND 9317;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9310,  8867, -6733, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9311,  9667, -7533, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9312,  9867, -6133, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9313,  8667, -7933, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9314,  8467, -6100, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9315, 10067, -6300, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9316,  8067, -7300, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0),
(9317, 10433, -7300, 100, 800, 1000, 530, 399, 383, 399, 383, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000431 AND 9000438;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000431, 1556783290, 9310, 0, 0),
(9000432, 1556783290, 9311, 0, 0),
(9000433, 1556783290, 9312, 0, 0),
(9000434, 1556783290, 9313, 0, 0),
(9000435, 1556783290, 9314, 0, 0),
(9000436, 1556783290, 9315, 0, 0),
(9000437, 1556783290, 9316, 0, 0),
(9000438, 1556783290, 9317, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 43;
