-- Structural repairs applied to the hotfix tables themselves, recorded here so a fresh database
-- gets them too.
--
-- `DB2DatabaseLoader::Load` compares the column count of the prepared statement with the record
-- layout and returns without a word when they differ: the whole table is then dropped, not one row.
-- Six tables on the sound and spell-visual path were in that state, five of them because the
-- parent identifier had no column at all.
--
-- MySQL has no `ADD COLUMN IF NOT EXISTS`, and this database already carries the columns, so each
-- one is added only where it is missing.
DROP PROCEDURE IF EXISTS `add_parent_column`;
DELIMITER $$
CREATE PROCEDURE `add_parent_column`(IN tbl VARCHAR(64), IN col VARCHAR(64), IN after_col VARCHAR(64))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                   WHERE table_schema = DATABASE() AND table_name = tbl AND column_name = col) THEN
        SET @stmt = CONCAT('ALTER TABLE `', tbl, '` ADD COLUMN `', col,
                           '` int NOT NULL DEFAULT 0 AFTER `', after_col, '`');
        PREPARE s FROM @stmt;
        EXECUTE s;
        DEALLOCATE PREPARE s;
    END IF;
END$$
DELIMITER ;

CALL `add_parent_column`('spell_visual_event', 'SpellVisualID', 'SpellVisualKitID');
CALL `add_parent_column`('spell_visual_kit_effect', 'SpellVisualKitID', 'Effect');
CALL `add_parent_column`('spell_visual_kit_model_attach', 'SpellVisualKitID', 'StartDelay');
CALL `add_parent_column`('gameobject_display_info_x_sound_kit', 'GameObjectDisplayInfoID', 'SoundKitID');
CALL `add_parent_column`('sound_emitters', 'MapID', 'PhaseGroupID');

DROP PROCEDURE `add_parent_column`;
