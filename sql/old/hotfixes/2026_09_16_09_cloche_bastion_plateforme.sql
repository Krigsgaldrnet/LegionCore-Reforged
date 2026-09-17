-- La cloche de Bastion réduite à sa plateforme : les deux pylônes sont effondrés dans le fichier et
-- les deux cloches, qui sont des accessoires M2, masquées à l'échelle 0. Le tout à 80 %.
--
-- La boîte suit la géométrie qui reste : elle passe de 29 m de haut à 2, sans quoi le client
-- découpe l'objet sur un volume que plus rien n'occupe.
UPDATE `gameobject_display_info` SET
    `GeoBoxMinX` = -21.66, `GeoBoxMinY` = -21.66, `GeoBoxMinZ` = 0.08,
    `GeoBoxMaxX` =  21.66, `GeoBoxMaxY` =  21.66, `GeoBoxMaxZ` = 2.11
WHERE `ID` = 47631;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 120;
