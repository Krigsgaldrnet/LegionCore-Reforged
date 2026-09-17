-- Pavillon dracthyr de Dalaran, decale de 3 m sur sa droite depuis -1288,49 / 4497,94.
-- La droite d'un objet est son cap tourne d'un quart de tour horaire : x + sin(o), y - cos(o).
UPDATE `gameobject` SET
    `position_x` = -1288.93,
    `position_y` = 4494.97
WHERE `guid` = 25685946 AND `id` = 2600051;
