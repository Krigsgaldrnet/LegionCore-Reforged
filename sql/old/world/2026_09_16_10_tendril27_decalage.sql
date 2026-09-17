-- Void tendril 27 at the Confluence, moved one metre to its own left.
--
-- Left is the object's heading turned a quarter turn counter-clockwise, which is the right-shift
-- helper given a negative distance: x - sin(o), y + cos(o) with o = 0.946074.
UPDATE `gameobject` SET
    `position_x` = -1033.73,
    `position_y` = -4099.88
WHERE `guid` = 25682569 AND `id` = 2600032;
