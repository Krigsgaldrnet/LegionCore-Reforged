-- ---------------------------------------------------------------------------------------------
-- Give Elwynn Forest and Stormwind the same Drustvar sky as Westfall.
--
-- Neither zone has a light of its own: Blizzard left them on Azeroth's default, Light 1, whose
-- parameters (12 clear, 13 underwater, 10 storm) are shared with every other stretch of the map
-- that has no local light. Editing those would repaint the sky of half a continent, so this adds
-- local lights instead - which is also how Westfall, Duskwood and Redridge are done.
--
-- Where the lights go was measured, not guessed: the area id of every map chunk between tiles
-- 28-37 / 45-54 was read, and seven circles of 800 reach cover 98.8% of the 6773 chunks the two
-- zones own. What they overrun is Westfall (which now carries this very sky), Duskwood, Burning
-- Steppes, Redridge, Searing Gorge and Dun Morogh - every one of them holds its own light, closer
-- to its own ground than ours, so it keeps its sky. The 1.2% left out sits on those same borders
-- and keeps the default, exactly as today.
--
-- Parameters 3704 and 3705 are copies of the default 12 and 10 with nothing changed but the
-- skybox, so day, night, sunrise and storm keep the colours and the fog Elwynn has always had.
-- The skybox model itself carries a day, a night and a sunrise texture that the client blends by
-- the hour; the weather is unaffected, it lives in the storm slot which is swapped the same way.
--
-- TableHash 1556783290 is Light and 3330215320 is LightParams - the header's TableHash field,
-- not its LayoutHash.
-- ---------------------------------------------------------------------------------------------

DELETE FROM `light_params` WHERE `ID` IN (3704, 3705);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.40000000596, 0.5, 1, 0.64999997616, 1, 0, 0, 0, 901, 1, 0, 0, 3704, 0),
(0.10000000149, 0.5, 1, 0.75,          1, 0, 0, 0, 901, 0, 0, 0, 3705, 0);

DELETE FROM `light` WHERE `ID` BETWEEN 9303 AND 9309;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9303, -9200,     0, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9304, -8000,  1000, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9305, -9200, -1200, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9306, -8600,  1400, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9307, -8000,     0, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9308, -9800,   400, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0),
(9309, -8000,  1600, 0, 600, 800, 0, 3704, 13, 3705, 13, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000397 AND 9000405;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000397, 3330215320, 3704, 0, 0),
(9000398, 3330215320, 3705, 0, 0),
(9000399, 1556783290, 9303, 0, 0),
(9000400, 1556783290, 9304, 0, 0),
(9000401, 1556783290, 9305, 0, 0),
(9000402, 1556783290, 9306, 0, 0),
(9000403, 1556783290, 9307, 0, 0),
(9000404, 1556783290, 9308, 0, 0),
(9000405, 1556783290, 9309, 0, 0);

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 37;
