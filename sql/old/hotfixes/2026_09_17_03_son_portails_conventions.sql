-- The departure sound was filed as zone music, so the client never played it as a spell sound.
--
-- Read from the client data: of the 15 030 sound kits a SpellVisualKitEffect of type 5 plays,
-- 13 291 are SoundType 1, and that family settles on MinDistance 8 with a cutoff of 45 yards.
-- Ours sat at SoundType 28 - the ZoneMusic channel - with no minimum distance and a cutoff of 80.
UPDATE `sound_kit` SET `SoundType` = 1, `MinDistance` = 8, `DistanceCutoff` = 45 WHERE `ID` = 98322;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 156;
