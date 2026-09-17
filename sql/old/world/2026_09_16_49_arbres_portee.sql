-- Même cause que le pavillon dracthyr et le portail : `VisibilityDistance` passe avant `MaxVisible`
-- dans `WorldObject::GetSightRange` et la remplace au lieu de s'y ajouter. À 1 500 les arbres
-- sortaient de portée dès qu'on s'éloignait, exactement comme le pavillon à 1 200.
UPDATE `gameobject_template` SET `VisibilityDistance` = 5000 WHERE `entry` BETWEEN 2600055 AND 2600063;
