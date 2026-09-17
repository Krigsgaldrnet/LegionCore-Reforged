-- Tendril du Vide VII réduit à 90 %, dans le fichier : ni la taille du gameobject ni le quaternion
-- de placement n'atteignent un objet de carte, le client le dessine à sa taille propre.
--
-- La boîte suit la géométrie mise à l'échelle, sans quoi le client découpe le modèle sur l'ancienne.
UPDATE `gameobject_display_info` SET
    `GeoBoxMinX` = -18.32, `GeoBoxMinY` = -53.65, `GeoBoxMinZ` = -19.38,
    `GeoBoxMaxX` =  18.32, `GeoBoxMaxY` =  44.24, `GeoBoxMaxZ` = 109.87
WHERE `ID` = 47629;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 117;
