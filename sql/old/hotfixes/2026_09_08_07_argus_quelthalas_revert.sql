-- Revert: Argus stays off map 530.
--
-- The zone-scoped attempt did not show in game. MapCelestialBody record 8 goes back to being a
-- deletion, as it has been since 2026-08-30, and the condition built for it is dropped. Record 15
-- never moved.
DELETE FROM `map_celestial_body` WHERE `ID` = 8;
DELETE FROM `player_condition` WHERE `ID` = 54103;

DELETE FROM `hotfix_data` WHERE `Id` IN (9000219, 9000440);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000219, 2523168314, 8, 0, 1);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 47;
