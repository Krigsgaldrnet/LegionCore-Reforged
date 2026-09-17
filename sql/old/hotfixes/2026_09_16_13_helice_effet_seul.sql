-- L'hélice du temple des mémoires réduite à son seul effet : les douze lots opaques, les onze
-- plaques et la structure qui les porte, sont retirés des skins. Restent les trois lots mélangés
-- qui dessinent la traînée lumineuse.
--
-- La boîte suit ce qui reste dessiné, recalculé sur les sommets que les lots survivants indexent.
UPDATE `gameobject_display_info` SET
    `GeoBoxMaxX` = 100.52
WHERE `ID` = 47637;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 124;
