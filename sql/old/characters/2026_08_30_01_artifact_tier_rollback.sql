-- ==========================================================================
-- Artifact tier 2 rollback for pre-7.2 servers
-- Run against characters_legion database
--
-- Artifact tier 2 used to unlock past 35 purchased traits at every patch,
-- because ArtifactTierEnable defaulted to "on" and was never tied to
-- Game.Patch. Tier 2 switches the artifact to the XP2 cost curve of
-- ArtifactLevelXP.txt, which assumes the 7.2/7.3 Knowledge multipliers
-- (x40001 / x6300001). Below 7.2 the rank 25 cap only gives x250, so the
-- next trait costs hundreds of times more Artifact Power than intended.
--
-- The core no longer flips new artifacts (World.cpp now defaults the setting
-- from Game.Patch), but artifacts that already flipped keep tier = 1 in the
-- database. This puts them back on the tier 1 curve.
--
-- Effect: affected artifacts return to the cheaper XP column. Traits that
-- belong to tier 2 stay recorded but stop being applied, which is the
-- expected state for a 7.0 / 7.1 / 7.1.5 server.
--
-- Only run this while the realm is on Game.Patch <= 3 (7.0 to 7.1.5).
-- Characters must be offline, otherwise a logout will write the old value back.
-- ==========================================================================

-- Review what will change before running the UPDATE:
--   SELECT a.char_guid, c.name, a.itemEntry, a.tier, a.totalrank, a.xp
--   FROM item_instance_artifact a
--   JOIN characters c ON c.guid = a.char_guid
--   WHERE a.tier <> 0;

UPDATE `item_instance_artifact` SET `tier` = 0 WHERE `tier` <> 0;
