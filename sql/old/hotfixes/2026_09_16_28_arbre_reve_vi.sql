-- A tenth dracthyr tree, retro-ported from 12.1. The served identifier is the one CASCHost handed
-- back, not the listfile's: the path was new here, but the rule stands - read it back after the
-- rebuild.
DELETE FROM `gameobject_display_info` WHERE `ID` = 47656;
INSERT INTO `gameobject_display_info`
 (`ID`, `FileDataID`, `GeoBoxMinX`, `GeoBoxMinY`, `GeoBoxMinZ`,
  `GeoBoxMaxX`, `GeoBoxMaxY`, `GeoBoxMaxZ`,
  `OverrideLootEffectScale`, `OverrideNameScale`, `ObjectEffectPackageID`, `VerifiedBuild`) VALUES
 (47656, 8001860, -0.84, -14.65, -1.60, 35.99, 12.88, 26.18, 1, 1, 0, 26972);

DELETE FROM `hotfix_data` WHERE `Id` = 9000610;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000610, 1829768651, 47656, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 140;
