-- 10xp_tree93's geometry sits entirely to one side of its origin: x runs from 0.7 to 36, nothing
-- behind. The GeoBox read from the model describes that faithfully, and the client then culls the
-- tree as soon as that lopsided box leaves the view - it vanishes depending on where you stand,
-- which is what happened at the Dalaran / open sea boundary.
--
-- A cube centred on the origin and large enough to hold the model keeps it in view from every
-- angle. Culling a little late costs nothing on a single decor object.
UPDATE `gameobject_display_info`
 SET `GeoBoxMinX` = -40, `GeoBoxMinY` = -40, `GeoBoxMinZ` = -40,
     `GeoBoxMaxX` =  40, `GeoBoxMaxY` =  40, `GeoBoxMaxZ` =  40
 WHERE `ID` = 47656;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 142;
