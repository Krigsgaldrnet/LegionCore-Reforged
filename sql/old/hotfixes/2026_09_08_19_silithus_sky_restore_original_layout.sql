-- Back to the arrangement that worked, with the sky that was asked for.
--
-- The user is right and it is worth writing down: the sky was on screen at update 08 and has not
-- been seen since update 10, which moved it onto the crater. Everything after that chased the
-- consequences of a move nobody asked for. The centring was mine, not a requirement.
--
-- So the three lights of map 1817 go back exactly where Blizzard put them, with the falloffs
-- Blizzard gave them. Nothing is positioned, nothing is invented, no light record is created.
--
--   9150  -6158 / 3473 / 0    897 - 1334
--   9151  -6419 /  -233 / 0    196 -  306
--   9152  -8401 /  -209 / 200  221 -  322
--
-- What changes is only which sky they show, and that is done inside the parameter sets they
-- already use rather than in parameter sets of my own. That difference matters: a parameter set
-- created here has no LightData, so it has no colours, and the client falls back to a default
-- lighting - the fog on screen. Edited in place, 254, 425, 253, 408, 1000 and 1002 keep every
-- colour and every fog distance the zone was authored with. Silithus keeps its own atmosphere and
-- gains a sky, which is what was asked for.
--
-- Every value below is read out of ClientData/dbc/frFR/LightParams.db2, so each record is rewritten
-- with its real glow and water alphas. Two fields move: LightSkyboxID to 905, and HighlightSky to
-- 1, which every sky hotfix that has worked on this realm carries.
--
-- The sky is 905, Castle Nathria - the model the user chose. The Icecrown sky, 903, is withdrawn
-- and its fourteen files are deleted from what CASCHost serves; update 20 removes its record.
--
-- What this costs, said plainly: these parameter sets are shared with map 1. 254 is used by a
-- single Kalimdor light, 250, at -6158 / 3473 - the same spot as 9150. 425 is used by six, 253 and
-- 408 by a few more. So the old Silithus timeline, and a couple of neighbouring spots, will show
-- this sky as well. That is the price of keeping the zone's real colours, since a private copy of
-- them cannot be published while LightData cloning is broken in this core. It can be narrowed once
-- something is visible.
--
-- TableHash 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_params` WHERE `ID` IN (254, 425, 253, 408, 1000, 1002);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0,  254, 26972),
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0,  425, 26972),
(0,    0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0,  253, 26972),
(0.4,  0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0,  408, 26972),
(0.1,  0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0, 1000, 26972),
(0.1,  0.5, 1, 0.75, 1, 0, 0, 0, 905, 1, 0, 0, 1002, 26972);

DELETE FROM `light` WHERE `ID` IN (9150, 9151, 9152);
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9150, -6158,  3473,   0, 897, 1334, 1817,  254, 207,  425, 207, 3, 0, 0, 0, 0),
(9151, -6419,  -233,   0, 196,  306, 1817,  253, 207,  408, 207, 3, 0, 0, 0, 0),
(9152, -8401,  -209, 200, 221,  322, 1817, 1000, 946, 1002,  11, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000458 AND 9000463;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000458, 3330215320,  254, 0, 0),
(9000459, 3330215320,  425, 0, 0),
(9000460, 3330215320,  253, 0, 0),
(9000461, 3330215320,  408, 0, 0),
(9000462, 3330215320, 1000, 0, 0),
(9000463, 3330215320, 1002, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 59;
