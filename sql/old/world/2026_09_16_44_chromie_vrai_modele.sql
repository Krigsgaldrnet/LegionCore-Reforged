-- Le premier import avait pris `igc_chromie`, une variante de cinématique : deux identifiants
-- d'animation seulement. Le vrai modèle en porte 292 sur 327 séquences.
--
-- Seul le fichier change, l'enregistrement d'affichage et le PNJ restent les mêmes. La boîte de
-- collision est identique entre les deux modèles, 0,31 de rayon pour 2,03 de haut.
UPDATE `hotfixes_legion`.`creature_model_data` SET `FileDataID` = 4218359 WHERE `ID` = 10735;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 132;
