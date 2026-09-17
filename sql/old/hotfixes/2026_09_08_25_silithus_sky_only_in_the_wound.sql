-- No light of Kalimdor carries the sky any more. It arrives only by substitution, per player.
--
-- A light knows nothing about timelines, so any Kalimdor light carrying the skybox showed it to
-- both eras at once. Naming that light in SMSG_OVERRIDE_LIGHT did not work - the client appears to
-- honour the packet only for the map's default light, which is the single form the core itself
-- ever sends. So the whole arrangement is turned round to use that form.
--
-- 9330 goes: nothing is positioned over the Wound any more.
--
-- 1002 keeps the skybox but is left with no user on map 1. It had five, the western lights of
-- Silithus, and they used it in their storm slot only; that slot moves to 1000, their own clear
-- parameter - same glow, same 90000 fog, same zone. On map 1817 it is still used by 9152, which
-- costs nothing since the client never reads that map's lights.
--
-- 9332 is the substitute: falloff 0/0 like the default light it stands in for, on map 1817 so it
-- can never be picked by position, pointing at 1002 in every above-water slot. The script hands it
-- to a player who stands in Silithus without the timeline marker, and takes it back - by naming
-- the default light as its own replacement - when they travel to the past or leave the zone.
--
-- Consequence to keep in mind: while it is in force the substitution replaces Kalimdor's default
-- light for that player, so the sky covers the zone rather than only the crater. That is the price
-- of the only form the client accepts, and in the Wound's own timeline the zone is the Wound.
--
-- TableHash 1556783290 Light.

DELETE FROM `light` WHERE `ID` IN (9330, 9332, 2759, 2760, 2765, 2766, 2767);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9332,     0,    0,   0,   0,   0, 1817, 1002, 207, 1002, 207, 3, 0, 0, 0, 0),
(2759, -8809, -653, 174, 320, 435,    1, 1000, 946, 1000,  11, 3, 0, 0, 0, 0),
(2760, -8936,  163, 141, 378, 531,    1, 1000, 946, 1000,  11, 3, 0, 0, 0, 0),
(2765, -9171,  886, 244, 233, 359,    1, 1000, 946, 1000,  11, 3, 0, 0, 0, 0),
(2766, -8401, -209, 199, 221, 322,    1, 1000, 946, 1000,  11, 3, 0, 0, 0, 0),
(2767, -9507, -151, 118, 228, 325,    1, 1000, 946, 1000,  11, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000466 AND 9000471;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000466, 1556783290, 9332, 0, 0),
(9000467, 1556783290, 2759, 0, 0),
(9000468, 1556783290, 2760, 0, 0),
(9000469, 1556783290, 2765, 0, 0),
(9000470, 1556783290, 2766, 0, 0),
(9000471, 1556783290, 2767, 0, 0);

-- 9330 est retire : sa ligne de correctif passe en Deleted.
UPDATE `hotfix_data` SET `Deleted` = 1 WHERE `TableHash` = 1556783290 AND `RecordID` = 9330;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 65;
