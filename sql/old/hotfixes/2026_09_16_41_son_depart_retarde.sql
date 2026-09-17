-- The departure sound had to land 0.3 s after the effect starts.
--
-- `SpellVisualKitEffect` carries no timing of its own - it is four columns, the kit and what to
-- play. The only delay in the chain sits on `SpellVisualKit`, and it holds back the whole kit.
-- The sound therefore has to leave 94941 and live in a kit of its own, which 7.3.5 does natively:
-- 47 stock kits carry a delay, and 67192 uses exactly 300 ms.
--
-- 94939 is free: the file stops at 94942, and 94940 and 94942 are taken.
DELETE FROM `spell_visual_kit` WHERE `ID` = 94939;
INSERT INTO `spell_visual_kit` (`ID`, `Flags`, `FallbackPriority`, `FallbackSpellVisualKitID`,
  `DelayMin`, `DelayMax`, `VerifiedBuild`) VALUES
 (94939, 0, 0, 0, 300, 300, 26972);

-- The sound row keeps its id and only changes owner, so 94941 is left with the model alone.
UPDATE `spell_visual_kit_effect` SET `SpellVisualKitID` = 94939 WHERE `ID` = 222248;

DELETE FROM `hotfix_data` WHERE `Id` = 9000610;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000610, 4102286043, 94939, 0, 0);   -- SpellVisualKit

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 152;
