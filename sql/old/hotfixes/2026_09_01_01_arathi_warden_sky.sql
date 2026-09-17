-- ---------------------------------------------------------------------------------------------
-- Give Arathi Basin the Vault of the Wardens sky.
--
-- Map 529 carries two lights. 326 is the global one, and 327 sits at (945,945) with a 1067 reach,
-- which covers the whole playable area: that local one is what the client actually resolves while
-- you stand in the battleground, so changing the global alone did nothing. Both are swapped for
-- the parameters of Light 7321, the single light of map 1468 WardenPrison, where the lightning
-- and the heavy clouds come from.
--
-- Slots are: 0 clear, 1 clear underwater, 2 storm, 3 storm underwater, 4 death.
-- The parameters carry the skybox and the fog together, so the mood comes as one piece.
--
-- TableHash 620911123 is Light (0x25025A13).
-- ---------------------------------------------------------------------------------------------

DELETE FROM `light` WHERE `ID` IN (326, 327);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(326,   0,   0, 0,   0,    0, 529, 2717, 9, 2717, 3, 0, 0, 0, 0, 26972),
(327, 945, 945, 0, 788, 1067, 529, 2717, 9, 2717, 3, 0, 0, 0, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000320, 9000326);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000320, 620911123, 326, 0, 0),
(9000326, 620911123, 327, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 26;
