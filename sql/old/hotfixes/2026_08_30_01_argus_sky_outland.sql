-- ---------------------------------------------------------------------------------------------
-- Keep Argus out of the Outland sky.
--
-- MapCelestialBody attaches the planet to eight maps, Outland among them. Outland is a shard of
-- another world and the portal Illidan opened links Argus to Azeroth, not to it. Blizzard treated
-- the map as a special case too: its glow row is the only one gated behind a ModifierTree.
--
-- Deleting the two rows is the only reliable way to do it. Simply not sending
-- SMSG_UPDATE_CELESTIAL_BODY on that map leaves whatever the previous map drew still hanging in
-- the sky, since the client redraws only when asked.
--
-- Record 8 is the planet, record 15 the post-Antorus glow. TableHash 2523168314 is MapCelestialBody.
-- ---------------------------------------------------------------------------------------------

ALTER TABLE `map_celestial_body`
  ADD COLUMN `MapID` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `PlayerConditionID`;

DELETE FROM `hotfix_data` WHERE `Id` IN (9000219, 9000220);
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
(9000219, 2523168314, 8,  0, 1),
(9000220, 2523168314, 15, 0, 1);
