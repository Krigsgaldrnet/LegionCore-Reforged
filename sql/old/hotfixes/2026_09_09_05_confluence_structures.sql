-- Display records for the three structures placed on map 2678.
--
-- A gameobject shows a model through GameObjectDisplayInfo, and that table names it by
-- FileDataID - which is why the three models are served under their own ids rather than the ones
-- CASCHost would hand out. It takes an M2 or a WMO indifferently, so the hourglass, a WMO, is
-- placed the same way as the two doodads.
--
-- The GeoBox is the model's own bounding box, read out of MOHD for the WMO and from offset 0xA0 of
-- MD20 for the M2s. It is what the client hit-tests against, so a box invented by hand would make
-- an object unclickable or clickable from far too far.
--
-- The time gate keeps the id CASCHost gave it rather than its own: it was already in the
-- published root from the WMO import, and for a path the root already knows AddEntry uses
-- that id, not the cache. Re-pointing the display record is cheaper than rebuilding a root.
--
-- Ids start at 60000: GameObjectDisplayInfo.db2 stops at 47692 here.
--
-- TableHash 1829768651 GameObjectDisplayInfo.

DELETE FROM `gameobject_display_info` WHERE `ID` = 60001;
INSERT INTO `gameobject_display_info` (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`,
                                       `GeoBoxMinZ`, `GeoBoxMaxX`, `GeoBoxMaxY`,
                                       `GeoBoxMaxZ`, `OverrideLootEffectScale`,
                                       `OverrideNameScale`, `ObjectEffectPackageID`,
                                       `VerifiedBuild`) VALUES
(60001, 4900803, -150.8, -130.6, -201.1, 75.5, 130.6, 146.1, 1, 1, 0, 26972);

DELETE FROM `gameobject_display_info` WHERE `ID` = 60002;
INSERT INTO `gameobject_display_info` (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`,
                                       `GeoBoxMinZ`, `GeoBoxMaxX`, `GeoBoxMaxY`,
                                       `GeoBoxMaxZ`, `OverrideLootEffectScale`,
                                       `OverrideNameScale`, `ObjectEffectPackageID`,
                                       `VerifiedBuild`) VALUES
(60002, 5017669, -27.8, -40.5, -68.7, 28.6, 40.5, 66.7, 1, 1, 0, 26972);

DELETE FROM `gameobject_display_info` WHERE `ID` = 60003;
INSERT INTO `gameobject_display_info` (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`,
                                       `GeoBoxMinZ`, `GeoBoxMaxX`, `GeoBoxMaxY`,
                                       `GeoBoxMaxZ`, `OverrideLootEffectScale`,
                                       `OverrideNameScale`, `ObjectEffectPackageID`,
                                       `VerifiedBuild`) VALUES
(60003, 8002658, -7.5, -14.5, -7.9, 8.4, 14.9, 20.8, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000487, 9000488, 9000489);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000487, 1829768651, 60001, 0, 0),
(9000488, 1829768651, 60002, 0, 0),
(9000489, 1829768651, 60003, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 73;
