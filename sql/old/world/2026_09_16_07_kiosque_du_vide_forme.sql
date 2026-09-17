-- Kiosque du Vide : réduit à 0,8, penché de 6° vers l'avant et de 7° sur sa gauche.
--
-- Tout dans le fichier : ni l'échelle ni l'assiette d'un gameobject n'atteignent un objet de carte.
-- Roulis autour de +X, qui amène le haut vers -Y, la droite du modèle — donc négatif pour la
-- gauche ; tangage autour de +Y, qui l'amène vers +X, son avant. Repris depuis la copie d'origine,
-- jamais depuis la version déjà transformée, sinon les angles se cumulent.
--
-- Boîte de l'affichage 47622 : -29.05, -29.01, -5.82, 28.69, 28.61, 40.44.
UPDATE `gameobject_template` SET `size` = 1 WHERE `entry` = 2600028;
