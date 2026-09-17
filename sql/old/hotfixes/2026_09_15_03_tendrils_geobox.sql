-- GeoBox des deux tendrils, qui avait été écrite à zéro.
--
-- La boîte englobante d'un WMO est à l'offset 0x24 de MOHD, pas 0x20 : les sept compteurs, puis la
-- couleur d'ambiance, puis l'identifiant, et seulement ensuite la boîte. Lue quatre octets trop tôt,
-- elle sort avec un minimum supérieur à son maximum - d'où le zéro que j'avais mis à la place, et
-- le crash #132 du client, violation d'accès sur pointeur nul à l'entrée dans le monde.
UPDATE `gameobject_display_info`
   SET `GeoBoxMinX` = -53.32, `GeoBoxMinY` = -44.22, `GeoBoxMinZ` = -70.02,
       `GeoBoxMaxX` =  37.68, `GeoBoxMaxY` =  48.97, `GeoBoxMaxZ` =  54.62
 WHERE `ID` = 47603;

UPDATE `gameobject_display_info`
   SET `GeoBoxMinX` = -3.44, `GeoBoxMinY` = -7.83, `GeoBoxMinZ` = 1.80,
       `GeoBoxMaxX` =  3.44, `GeoBoxMaxY` =  6.02, `GeoBoxMaxZ` = 32.18
 WHERE `ID` = 47604;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 98;
