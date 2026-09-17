-- La lumière par défaut de la carte pointait sur les paramètres 2678, qui n'ont aucune ligne dans
-- light_data : rien à rendre, donc le client retombait sur son éclairage générique. C'est pour ça
-- que l'import des lumières officielles ne changeait rien à l'oeil - elles sont bien reçues et
-- acceptées (le Hotfix.log du client les marque « valid »), mais elles ne couvrent que leur rayon,
-- et tout le reste de la carte restait sans données.
--
-- 3637 est le jeu officiel de la zone des plateformes (ex-6077), avec son plan de brouillard à
-- 6206. Les plateformes de glace, 6100 unités plus bas, gardent leurs propres lumières
-- positionnées (paramètres 3629 à 3633, plan de brouillard à 63-117).
UPDATE `light`
   SET `LightParamsID1` = 3637, `LightParamsID2` = 3637, `LightParamsID3` = 3637,
       `LightParamsID4` = 3637, `LightParamsID5` = 3637, `LightParamsID6` = 3637,
       `LightParamsID7` = 3637, `LightParamsID8` = 3637
 WHERE `ID` = 9500;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 90;

-- Le ciel custom de la carte vivait dans les paramètres 2678 (LightSkyboxID = 2678). Repointer la
-- lumière par défaut sur les paramètres officiels l'a donc supprimé : les jeux importés de
-- Dragonflight désignent des ciels 631/643/645 qui n'existent pas en 7.3.5, mis à 0 à l'import.
-- Le jeu officiel garde ses valeurs de lumière et de brouillard, et reprend le ciel de la carte.
UPDATE `light_params` SET `LightSkyboxID` = 2678 WHERE `ID` = 3637;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 91;
