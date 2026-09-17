-- Two models for the Maw entrance: the arch, which is only decor, and the portal itself.
--
-- The GeoBox is a generous cube centred on the origin rather than the model's own bounds. The
-- client culls on this box, and an off-centre or tight one makes the object blink out depending on
-- where the camera stands - the mistake that made the dream tree vanish. Culling late costs
-- nothing here, and the portal's body is particles, which never show up in the vertex bounds.
DELETE FROM `gameobject_display_info` WHERE `ID` IN (47657, 47658);
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47657, 4062864, -10, -10, -6, 10, 10, 14, 1, 1, 0, 26972),   -- 9fx_generic_maw_portal01
 (47658, 4177571, -18, -18, -6, 18, 18, 34, 1, 1, 0, 26972);   -- 9du_torghastraid_portalshell01

DELETE FROM `hotfix_data` WHERE `Id` IN (9000615, 9000616);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000615, 1829768651, 47657, 0, 0),
 (9000616, 1829768651, 47658, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 143;
