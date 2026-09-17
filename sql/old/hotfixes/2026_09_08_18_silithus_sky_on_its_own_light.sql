-- Silithus keeps its own light, and only gains a sky.
--
-- Every attempt so far tried to build a parameter set beside the zone's. That cannot work: colours
-- live in LightData, LightData is keyed by LightParamID, and cloning it is broken in this core. A
-- new parameter set is therefore always a set with no colours - which is the fog on screen.
--
-- The way round is to stop building anything and edit the zone's own parameter set in place. 254
-- is the clear slot of light 9150, the largest of the three Blizzard put on map 1817. Its LightData
-- is untouched and stays in the client's own DB2, so Silithus keeps the red-orange cast and the
-- distant fog it was authored with - FogEnd 14000, nothing near the camera.
--
-- Read out of ClientData/dbc/frFR/LightParams.db2, so the record is rewritten with its real values
-- rather than plausible ones: Glow 0.75, water 0.5/1, ocean 0.75/1, no celestial override.
--
-- Two fields change. LightSkyboxID becomes 904, the Dragonflight timeway sky. HighlightSky goes
-- from 0 to 1, which is what every sky hotfix that has ever worked on this realm carries.
--
-- What this costs, stated rather than discovered later: 254 is not exclusive to map 1817. One
-- light on map 1 uses it - record 250, at -6158 / 3473 with a reach of 1335, the same spot as 9150
-- before it moved. So the far north of old Silithus gets this sky too, in the past timeline. It is
-- the only sharing there is; 425, the storm slot, is used by six lights across several zones and
-- is left alone entirely - slot 3 of 9150 points at 254 instead, so weather cannot take the sky
-- away without touching a parameter that belongs to other zones.
--
-- 9150 moves onto the crater, measured from the creatures of the Wound phase: 335 of them stand
-- below z -50, down to -106, centred on -6909 / 678. Magni Bronzebeard, who stands at the Wound,
-- is at -7068 / 1257 / -93. 500 in and 900 out, so the sky is full over the hole and gone before
-- Zidormi, 1000 out. 9151 and 9152 stay as Blizzard made them.
--
-- TableHash 3330215320 LightParams, 1556783290 Light.

DELETE FROM `light_params` WHERE `ID` = 254;
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.75, 0.5, 1, 0.75, 1, 0, 0, 0, 904, 1, 0, 0, 254, 26972);

DELETE FROM `light` WHERE `ID` = 9150;
INSERT INTO `light` (`ID`, `GameCoordsX`, `GameCoordsY`, `GameCoordsZ`, `GameFalloffStart`, `GameFalloffEnd`,
                     `ContinentID`, `LightParamsID1`, `LightParamsID2`, `LightParamsID3`, `LightParamsID4`,
                     `LightParamsID5`, `LightParamsID6`, `LightParamsID7`, `LightParamsID8`, `VerifiedBuild`) VALUES
(9150, -6909, 678, -100, 500, 900, 1817, 254, 207, 254, 207, 3, 0, 0, 0, 0);

DELETE FROM `hotfix_data` WHERE `Id` = 9000458;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000458, 3330215320, 254, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 58;
