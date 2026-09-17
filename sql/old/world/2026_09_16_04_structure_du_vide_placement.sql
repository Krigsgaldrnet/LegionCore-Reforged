-- Structure du Vide posée à la Confluence : 20 m sur sa droite, 15 m sur sa gauche, 10 m en
-- arrière, puis 5 m en avant.
--
-- La droite d'un objet est son cap tourné d'un quart de tour horaire ; reculer, c'est avancer d'une
-- distance négative le long de ce cap.
--
-- Pas d'inclinaison : le serveur envoie bien la rotation complète — UPDATEFLAG_ROTATION est posé
-- sur tout gameobject et GetPackedWorldRotation part dans le bloc de création — mais le client ne
-- l'applique pas à un objet de carte affiché par un type 33, il n'en garde que le lacet.
UPDATE `gameobject` SET
    `position_x` = -1035.27,
    `position_y` = -4062.39
WHERE `guid` = 25681600 AND `id` = 2600011;
