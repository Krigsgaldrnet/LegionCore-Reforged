-- The three imported WMO are shown through a gameobject, and type 14 MAP_OBJECT crashes the 7.3.5
-- client the moment the model is drawn: access violation at 0x10, error 132. So does type 5, which
-- was verified on a purely native object - Guard Tower 20816, whose files this server does not even
-- serve. Of the 818 native displays that point at a WMO, only 257 sit in type 33 and 84 in type 15;
-- types 5 and 14 are leftovers that no longer work.
--
-- Type 33 does work: Light's Point Tower 190568, same display 628 as the tower that crashed. This
-- copies its configuration exactly - flags and Data18, everything else left at zero.
UPDATE `gameobject_template` SET
    `type`  = 33,
    `flags` = 1048608,
    `Data18` = 26
WHERE `entry` IN (2600009, 2600010, 2600011);
