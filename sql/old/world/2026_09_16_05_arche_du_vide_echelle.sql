-- Arche du Vide agrandie de 30 %.
--
-- Comme pour la Structure du Vide, pas par `size` : l'échelle d'un gameobject ne touche pas un WMO.
-- La géométrie est mise à l'échelle dans le fichier par redimensionner_wmo.py, depuis la copie
-- d'origine et non depuis la version déjà agrandie, pour que le facteur reste exact.
--
-- La boîte de l'affichage 47624 suit : -4.92, -16.66, -0.75, 4.83, 17.09, 35.12.
-- Sans elle, le client garderait l'ancienne enveloppe pour la sélection et la visibilité à distance.
UPDATE `gameobject_template` SET `size` = 1 WHERE `entry` = 2600030;
