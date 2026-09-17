-- Two custom game object models for map 2678: the sky vortex that hangs below the platforms, and
-- the soul anchor portal.
--
-- GameObjectDisplayInfo is a client table. A row added here reaches the client only through
-- hotfix_data, and the client only re-asks for it when the cache id moves - hence the bump at the
-- end. The ids stay below the file's max_id, 47692, read from the header of
-- ClientData/dbc/frFR/GameObjectDisplayInfo.db2: above it the server drops the record and the
-- client crashes. 47600 and 47601 are absent from the file's id list, so nothing is overridden.
--
-- GeoBox is the model's own bounding box, read from its MD20 header. It is what the server uses to
-- decide where a click lands, so a wrong one makes a clickable object unclickable.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47600, 47601);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47600, 8004035, -23.7, -28.7, -2.3, 23.7, 28.7,  4.1, 1, 1, 0, 26972),
 (47601, 3656198,  -4.4,  -4.5, -2.2,  4.4,  4.5, 10.4, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` IN (9000490, 9000491) AND `TableHash` = 1829768651;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000490, 1829768651, 47600, 0, 0),
 (9000491, 1829768651, 47601, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 87;
