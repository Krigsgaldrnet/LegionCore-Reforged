-- Boucle sonore des deux portails de la Confluence.
--
-- Le client suit `GameObjectDisplayInfo.ObjectEffectPackageID` → `ObjectEffectPackageElem` →
-- `ObjectEffect`. Les deux tables « conteneur », `ObjectEffectPackage` et `ObjectEffectGroup`,
-- n'existent pas en 7.3.5 : les numéros de paquet et de groupe ne sont que des clés de jointure,
-- donc libres. 1900 et 1950 passent au-dessus du plus grand utilisé, 1110 et 1865.
--
-- Conventions relevées sur les paquets natifs 421 et 788, pas devinées : pour une ambiance en
-- boucle, `TriggerType` 2, `EventType` 0, `EffectRecType` 1 — qui désigne un SoundKit — et
-- `StateType` 19 côté élément.
DELETE FROM `object_effect` WHERE `ID` = 2541;
INSERT INTO `object_effect`
 (`ID`, `Offset1`, `Offset2`, `Offset3`, `ObjectEffectGroupID`, `TriggerType`, `EventType`,
  `EffectRecType`, `Attachment`, `EffectRecID`, `ObjectEffectModifierID`, `VerifiedBuild`) VALUES
 (2541, 0, 0, 0, 1950, 2, 0, 1, 0, 98323, 0, 26972);

DELETE FROM `object_effect_package_elem` WHERE `ID` = 3398;
INSERT INTO `object_effect_package_elem`
 (`ID`, `ObjectEffectPackageID`, `ObjectEffectGroupID`, `StateType`, `VerifiedBuild`) VALUES
 (3398, 1900, 1950, 19, 26972);

UPDATE `gameobject_display_info` SET `ObjectEffectPackageID` = 1900 WHERE `ID` IN (47642, 47646);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 9000575 AND 9000578;
INSERT INTO `hotfix_data` (`Id`, `TableHash`, `RecordID`, `Timestamp`, `Deleted`) VALUES
 (9000575, 1734738485,   2541, 0, 0),
 (9000576, 3408032706,   3398, 0, 0),
 (9000577, 1829768651,  47642, 0, 0),
 (9000578, 1829768651,  47646, 0, 0);

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 138;
