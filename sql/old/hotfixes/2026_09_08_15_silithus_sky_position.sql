-- The sky was lit two thousand yards from the crater.
--
-- Light 9001 sat at -6967 / 2700, a point I had taken for the bottom of the Wound by reading the
-- terrain of map 1817. The conversion from chunk to world coordinates was wrong on the y axis, and
-- nothing caught it: the record was published, the client accepted it, and the falloff of 1100
-- simply never reached anywhere a player stands. Zidormi is 2961 yards from that point.
--
-- The crater is measured from the creatures this time, which cannot be misconverted. Of the ones
-- carrying phase 10277, 335 stand below z -50, down to -106; they are centred on -6909 / 678 with
-- a mean radius of 212 and a maximum of 769. Magni Bronzebeard, who stands at the Wound, is at
-- -7068 / 1257 / -93, inside that.
--
-- 500 in and 900 out: full over the crater, gone before Zidormi, who is 1000 yards from the
-- centre. So the sky rises as one walks down towards the blade, which is what was asked.
--
-- What this does not settle: whether the client resolves lights through the terrain swap at all.
-- The record lives on ContinentID 1817 while the player is physically on map 1. Blizzard put the
-- Wound's own three lights, 9150 to 9152, on 1817 too, and the Wound is a terrain swap in retail,
-- which is the argument for it - but it is an argument, not a measurement. If nothing shows once
-- the light is in the right place, that is the next thing to test.
DELETE FROM `light` WHERE `ID` = 9001;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9001, -6909, 678, -100, 500, 900, 1817, 3706, 11, 3706, 11, 3, 0, 0, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 55;
