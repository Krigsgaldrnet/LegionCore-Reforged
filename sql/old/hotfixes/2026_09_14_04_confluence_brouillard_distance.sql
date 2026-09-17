-- Brouillard de distance de la Confluence : net de près, estompé au loin.
--
-- Le jeu 3637 est celui des plateformes - la lumière 9248 le porte, et la lumière par défaut de la
-- carte aussi. Il arrivait de Dragonflight avec FogEnd et FogScaler à zéro, parce que cette version
-- a déplacé le brouillard de distance vers MainFogStartDist / MainFogEndDist, deux champs qu'un
-- client 7.3.5 ne lit pas. Or FogEnd n'est pas « pas de brouillard » : c'est la distance à laquelle
-- le brouillard est *plein*. À zéro, il l'est dès le premier mètre - d'où tout l'environnement
-- proche délavé.
--
-- FogScaler est la fraction de FogEnd où le brouillard commence : 4000 x 0,1875 = 750 unités de
-- netteté complète, puis une montée progressive jusqu'à 4000.
UPDATE `light_data`
   SET `FogEnd` = 4000, `FogScaler` = 0.1875
 WHERE `LightParamID` = 3637;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 94;
