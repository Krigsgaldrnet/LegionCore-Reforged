-- Chromie, avec le modèle rétroporté de la 12.1.
--
-- Les statistiques et les drapeaux sont repris de la Chromie native 10667 : faction 35, amicale et
-- non attaquable, `unit_flags` 33536, `npcflag` 3 pour la conversation et les quêtes.
DELETE FROM `creature_template` WHERE `entry` = 2600001;
INSERT INTO `creature_template`
 (`entry`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`,
  `unit_class`, `unit_flags`, `baseattacktime`, `AIName`, `MovementType`, `RegenHealth`,
  `flags_extra`, `MaxVisible`, `WorldEffects`, `PassiveSpells`, `ScriptName`) VALUES
 (2600001, 110, 110, 35, 3, 1, 1.14286, 1, 1, 33536, 2000, '', 0, 1, 2, 0, '', '', '');

DELETE FROM `creature_template_wdb` WHERE `Entry` = 2600001;
INSERT INTO `creature_template_wdb`
 (`Entry`, `Name1`, `Title`, `CursorName`, `TypeFlags`, `Type`, `Classification`,
  `Displayid1`, `HpMulti`, `PowerMulti`, `Leader`, `RequiredExpansion`, `VerifiedBuild`) VALUES
 (2600001, 'Chromie', 'Gardienne du temps', '', 0, 2, 0,
  83273, 1, 1, 0, 6, 26972);

-- Rayon et allonge, sans quoi le serveur retombe sur des valeurs par défaut qui ne collent pas à un
-- gnome : la boîte de collision du modèle donne 0,31 de rayon.
DELETE FROM `creature_model_info` WHERE `DisplayID` = 83273;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `hostileId`) VALUES
 (83273, 0.31, 1.5, 0, 0);
