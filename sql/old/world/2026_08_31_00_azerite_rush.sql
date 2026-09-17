-- ==========================================================================================
-- Azerite Rush - world side
--
-- A Seething Shore style mode hosted by an existing battleground map. The map is only geometry:
-- Arathi Basin keeps its own BattlegroundTypeId (3), its own class and its own banners, and none
-- of that is touched here. The new mode is type 900, a record the hotfix tables add to
-- BattlemasterList.db2 (see sql/updates/hotfixes/2026_08_31_00_azerite_rush_hotfixes.sql).
--
-- Nothing in this file spawns anything: the azerite nodes are created by the battleground class
-- at runtime, so they cannot leak into an Arathi Basin instance, and Arathi Basin's banners
-- cannot leak into an Azerite Rush one.
--
-- Run against the world database.
-- ==========================================================================================

-- ------------------------------------------------------------------------------------------
-- Per map tuning
-- ------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `battleground_azerite_rush_map`;
CREATE TABLE `battleground_azerite_rush_map` (
  `MapID`             SMALLINT UNSIGNED NOT NULL,
  `ActiveNodes`       TINYINT UNSIGNED  NOT NULL DEFAULT 3     COMMENT 'K: nodes live at the same time, must stay below the pool size',
  `ScorePerCapture`   INT UNSIGNED      NOT NULL DEFAULT 100,
  `ScoreToWin`        INT UNSIGNED      NOT NULL DEFAULT 1500,
  `NearVictoryScore`  INT UNSIGNED      NOT NULL DEFAULT 1200,
  `RespawnDelayMs`    INT UNSIGNED      NOT NULL DEFAULT 5000  COMMENT 'wait before a captured node is replaced elsewhere',
  `MinNodeDistance`   FLOAT             NOT NULL DEFAULT 0     COMMENT 'yards between two simultaneously active nodes, 0 disables the check',
  `ChannelDurationMs` INT UNSIGNED      NOT NULL DEFAULT 4000  COMMENT 'must match the duration of ChannelSpell, the server owns the timing',
  `ChannelSpell`      INT UNSIGNED      NOT NULL DEFAULT 0     COMMENT 'cast bar shown while mining, 0 = no visual',
  `HonorPerCapture`   INT UNSIGNED      NOT NULL DEFAULT 30,
  `AllianceGraveyard` INT UNSIGNED      NOT NULL DEFAULT 0     COMMENT 'WorldSafeLocs id, used only when there is no airship',
  `HordeGraveyard`    INT UNSIGNED      NOT NULL DEFAULT 0,
  `AllianceTransport` INT UNSIGNED      NOT NULL DEFAULT 0     COMMENT 'gameobject_template entry of the airship, 0 = ground graveyards',
  `HordeTransport`    INT UNSIGNED      NOT NULL DEFAULT 0,
  `AllianceDropZ`     FLOAT             NOT NULL DEFAULT 25    COMMENT 'height above the transport floor where players are placed',
  `HordeDropZ`        FLOAT             NOT NULL DEFAULT 25,
  `ParachuteSpell`    INT UNSIGNED      NOT NULL DEFAULT 0,
  `SafeFallSpell`     INT UNSIGNED      NOT NULL DEFAULT 0,
  `FallGuardZ`        FLOAT             NOT NULL DEFAULT 0     COMMENT 'during the countdown, a player below this Z is put back on the ship',
  `Comment`           VARCHAR(64)       NULL DEFAULT NULL,
  PRIMARY KEY (`MapID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------------------------------------
-- Node pool and gates
--   Type 0 = azerite node, 1 = alliance gate, 2 = horde gate
--   Rotation columns left at 0 are derived from Orientation by the core.
-- ------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `battleground_azerite_rush_node`;
CREATE TABLE `battleground_azerite_rush_node` (
  `MapID`       SMALLINT UNSIGNED NOT NULL,
  `Idx`         TINYINT UNSIGNED  NOT NULL,
  `Type`        TINYINT UNSIGNED  NOT NULL DEFAULT 0,
  `Entry`       INT UNSIGNED      NOT NULL DEFAULT 0 COMMENT 'gameobject entry, 0 = the mode default (281307)',
  `PositionX`   FLOAT             NOT NULL DEFAULT 0,
  `PositionY`   FLOAT             NOT NULL DEFAULT 0,
  `PositionZ`   FLOAT             NOT NULL DEFAULT 0,
  `Orientation` FLOAT             NOT NULL DEFAULT 0,
  `Rotation0`   FLOAT             NOT NULL DEFAULT 0,
  `Rotation1`   FLOAT             NOT NULL DEFAULT 0,
  `Rotation2`   FLOAT             NOT NULL DEFAULT 0,
  `Rotation3`   FLOAT             NOT NULL DEFAULT 0,
  `Comment`     VARCHAR(64)       NULL DEFAULT NULL,
  PRIMARY KEY (`MapID`, `Idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------------------------------------
-- Airships. Display ids 9002 and 9001 are the Seething Shore gunships; the taxi paths they
-- follow are created in the hotfixes file and circle above the basin.
-- Data0 = taxi path, Data1 = move speed, Data2 = acceleration.
-- ------------------------------------------------------------------------------------------
DELETE FROM `gameobject_template` WHERE `entry` IN (900001, 900002);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `Data0`, `Data1`, `Data2`) VALUES
(900001, 15, 9002, 'Azerite Rush Alliance Airship', 1, 6800, 4, 1),
(900002, 15, 9001, 'Azerite Rush Horde Airship',    1, 6801, 4, 1);

-- ------------------------------------------------------------------------------------------
-- Arathi Basin, first test map.
--
-- The pool starts on the five capture points of the original mode, as asked, then fills up to
-- twelve with positions the core already spawns something at (the five buff spots and two of the
-- spirit guides). Every coordinate below is taken from BattlegroundArathiBasin.h, so all of them
-- sit on ground Blizzard itself uses - no surveying was invented here.
-- ------------------------------------------------------------------------------------------
DELETE FROM `battleground_azerite_rush_map` WHERE `MapID` = 529;
INSERT INTO `battleground_azerite_rush_map`
  (`MapID`, `ActiveNodes`, `ScorePerCapture`, `ScoreToWin`, `NearVictoryScore`, `RespawnDelayMs`, `MinNodeDistance`,
   `ChannelDurationMs`, `ChannelSpell`, `HonorPerCapture`, `AllianceGraveyard`, `HordeGraveyard`,
   `AllianceTransport`, `HordeTransport`, `AllianceDropZ`, `HordeDropZ`, `ParachuteSpell`, `SafeFallSpell`, `FallGuardZ`, `Comment`) VALUES
  (529, 3, 100, 1500, 1200, 5000, 150, 4000, 900500, 30, 890, 889, 900001, 900002, 25, 25, 262359, 262086, 120, 'Arathi Basin');

DELETE FROM `battleground_azerite_rush_node` WHERE `MapID` = 529;
INSERT INTO `battleground_azerite_rush_node`
  (`MapID`, `Idx`, `Type`, `Entry`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Rotation0`, `Rotation1`, `Rotation2`, `Rotation3`, `Comment`) VALUES
-- the five original capture points
  (529,  0, 0, 0, 1166.856, 1200.122,  -56.720, 0.8860929, 0, 0, 0.4286938, 0.9034498, 'Stables'),
  (529,  1, 0, 0,  977.5052, 1051.073, -44.792, 0.4971090, 0, 0, 0.2460032, 0.9692690, 'Blacksmith'),
  (529,  2, 0, 0,  806.2500,  874.2795, -56.0102, 0.8182427, 0, 0, 0.3978033, 0.9174708, 'Farm'),
  (529,  3, 0, 0,  856.8663, 1150.214,  11.38484, 0.9897078, 0, 0, 0.4749031, 0.8800381, 'Lumber mill'),
  (529,  4, 0, 0, 1146.929,  848.2274, -110.917, 2.4171010, 0, 0, 0.9351034, 0.3543750, 'Gold mine'),
-- spread, taken from the buff spawns
  (529,  5, 0, 0, 1185.71, 1185.24,  -56.36, 2.56, 0, 0, 0, 0, 'Stables buff'),
  (529,  6, 0, 0,  990.75, 1008.18,  -42.60, 2.43, 0, 0, 0, 0, 'Blacksmith buff'),
  (529,  7, 0, 0,  817.66,  843.34,  -56.54, 3.01, 0, 0, 0, 0, 'Farm buff'),
  (529,  8, 0, 0,  807.46, 1189.16,   11.92, 5.44, 0, 0, 0, 0, 'Lumber mill buff'),
  (529,  9, 0, 0, 1146.62,  816.94,  -98.49, 6.14, 0, 0, 0, 0, 'Gold mine buff'),
-- spread, taken from two spirit guide spots that sit furthest from their base
  (529, 10, 0, 0,  775.17, 1206.40,   15.79, 1.90, 0, 0, 0, 0, 'Lumber mill ridge'),
  (529, 11, 0, 0, 1207.48,  787.00,  -83.36, 5.51, 0, 0, 0, 0, 'Gold mine ridge');

-- ------------------------------------------------------------------------------------------
-- Battleground template. Weight 0 keeps the mode out of the random battleground pool: it is
-- picked by name in the PvP finder and nowhere else.
-- ------------------------------------------------------------------------------------------
DELETE FROM `battleground_template` WHERE `id` = 900;
INSERT INTO `battleground_template` (`id`, `AllianceStartLoc`, `HordeStartLoc`, `Weight`, `ScriptName`, `MinPlayersPerTeam`, `Comment`) VALUES
(900, 890, 889, 0, '', 10, 'Azerite Rush - Arathi Basin');

-- The client caches hotfixes; without this bump it keeps serving the old BattlemasterList.
UPDATE `version` SET `hotfix_cache_id` = 5;
