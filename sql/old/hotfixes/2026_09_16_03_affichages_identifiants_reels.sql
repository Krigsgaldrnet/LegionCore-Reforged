-- Sept affichages pointaient un identifiant que CASCHost ne sert pas.
--
-- Un modèle déposé ne garde pas toujours l'identifiant que le listfile lui donne : quand cet
-- identifiant est déjà pris côté client, ou quand le fichier est réécrit par la conversion,
-- l'import lui en réserve un neuf dans la plage 8004xxx. C'est systématique pour une racine de WMO,
-- que le convertisseur réécrit toujours. L'affichage doit donc être lu dans `root_entries`, jamais
-- dans le listfile.
--
-- Symptôme : le client dessine un grand carré rose, faute de trouver le fichier.
UPDATE `gameobject_display_info` SET `FileDataID` = 8004057 WHERE `ID` = 47613;   -- 12vd_void_decor_floatinginteractible02.m2
UPDATE `gameobject_display_info` SET `FileDataID` = 8004046 WHERE `ID` = 47614;   -- 12vd_void_crafting_tool02.m2
UPDATE `gameobject_display_info` SET `FileDataID` = 8004099 WHERE `ID` = 47616;   -- 12vd_void_crafting_channelingwardrobe01.m2
UPDATE `gameobject_display_info` SET `FileDataID` = 8004098 WHERE `ID` = 47617;   -- 12vd_void_storage_treasurechest01.m2
UPDATE `gameobject_display_info` SET `FileDataID` = 8004153 WHERE `ID` = 47622;   -- 12vd_void_gazebo01.wmo
UPDATE `gameobject_display_info` SET `FileDataID` = 8004151 WHERE `ID` = 47623;   -- 12du_voidraid_entrance01.wmo
UPDATE `gameobject_display_info` SET `FileDataID` = 8004154 WHERE `ID` = 47624;   -- 12vd_void_archway01.wmo

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 107;
