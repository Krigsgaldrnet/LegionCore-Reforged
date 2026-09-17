-- ---------------------------------------------------------------------------------------------
-- Widen the Elwynn and Stormwind lights so the sky stops fading in and out.
--
-- The seven lights covered 98.8% of the two zones, but only within their falloff END. Between
-- START and END a light is blended with whatever else reaches the point - here Azeroth's default
-- sky - so a fifth of the ground, and a fifth of Stormwind, was showing a mixture rather than the
-- Drustvar sky. Crossing that band, on foot or in the air, is what made the sky come and go.
--
-- Measured against the same chunk map: at 1000 the seven centres hold 100% of both zones, so the
-- reach is raised from 600/800 to 1000/1300. Full strength everywhere on the ground, and the
-- blend band now falls entirely on the neighbours, which have their own closer lights.
--
-- The centres are also lifted from sea level to 100, near the ground of the two zones. A light is
-- a sphere: at sea level, a camera five hundred units up spends that much of the radius climbing
-- to it - the very case, flying over Stormwind, where the sky was dropping out.
--
-- TableHash 1556783290 is Light.
-- ---------------------------------------------------------------------------------------------

UPDATE `light` SET `GameCoordsZ` = 100, `GameFalloffStart` = 1000, `GameFalloffEnd` = 1300
WHERE `ID` BETWEEN 9303 AND 9309;

-- The client keeps serving its cached tables until this version moves.
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 38;
