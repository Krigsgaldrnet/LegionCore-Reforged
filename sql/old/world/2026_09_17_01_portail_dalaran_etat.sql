-- The Dalaran side portal played a closing animation while its twin in the Confluence looped.
--
-- The difference was its spawn state: `.gob add` writes 1, which the client reads as closed, and
-- 0 is what holds the looping animation. The Confluence portal was already at 0.
UPDATE `gameobject` SET `state` = 0, `animprogress` = 255 WHERE `id` = 2600053;
