-- The sky vortex and the soul anchor portal of map 2678, as game objects rather than ADT doodads.
--
-- Doodads placed in the tile's _obj0 never reach the screen on this map, while the game object
-- already used there - the time gate, entry 2600003 - does. A game object also carries its own
-- scale and keeps its animation playing, which is what both of these need.
--
-- type 5 (GENERIC) has no interaction at all: the vortex only has to turn.
-- type 10 (GOOBER) is the clickable one. Every Data field is left at zero for now, so a click does
-- nothing; the teleport spell will go into Data10 when it exists.
DELETE FROM `gameobject_template` WHERE `entry` IN (2600004, 2600005);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`) VALUES
 (2600004,  5, 47600, 'Vortex des âmes', 32),
 (2600005, 10, 47601, 'Ancre des âmes',   1);

DELETE FROM `gameobject` WHERE `id` IN (2600004, 2600005);
INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`,
  `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `AiID`, `state`, `isActive`, `personal_size`) VALUES
 (25681040, 2600004, 2678, 15010, 15010, 1, 1, '', -2174.3, -5098.3, 6120.0, 0, 0, 0, 0, 1, 300, 0, 0, 1, 1, 0),
 (25681041, 2600005, 2678, 15010, 15010, 1, 1, '', -2190.0, -5113.0, 6283.0, 0, 0, 0, 0, 1, 300, 0, 0, 1, 1, 0);

-- Le vortex est un élément de fond de 1517 unités de large : 500 yards, la portée que la carte
-- applique par défaut, le fait disparaître avant même qu'on ait traversé la zone.
--
-- MaxVisible est indispensable en plus de la portée : c'est lui qui inscrit l'objet dans
-- Map::m_MaxVisibleList, donc hors du parcours des cellules. Sans lui, une portée seule ne sert à
-- rien - l'objet n'est proposé que si sa grille est chargée. L'ancre, elle, reste au défaut :
-- c'est un objet qu'on vient toucher de près.
UPDATE `gameobject_template` SET `MaxVisible` = 1, `VisibilityDistance` = 3000 WHERE `entry` = 2600004;

-- Portée portée à 6000 : le vortex sert de fond à toute la zone.
UPDATE `gameobject_template` SET `VisibilityDistance` = 6000 WHERE `entry` = 2600004;

-- Le portail passe en type 22 (SPELLCASTER), celui que Blizzard emploie pour ses 339 portails :
-- Data0 reçoit le sort lancé au clic, Data1 le nombre de charges - 0 signifie sans limite, donc on
-- peut cliquer autant de fois qu'on veut, contrairement à une porte qui ne s'ouvre qu'une fois.
-- Data2 (partyOnly) doit rester à 0 : le cœur exige sinon un propriétaire et refuse l'interaction.
-- Data3 (allowMounted) à 1 pour ne pas démonter le joueur.
UPDATE `gameobject_template`
   SET `name` = 'Portail vers l''Antre', `type` = 22,
       `Data0` = 0, `Data1` = 0, `Data2` = 0, `Data3` = 1
 WHERE `entry` = 2600005;

-- Positions relevees telles qu'elles sont en jeu apres reglage. Elles vivent ici et pas seulement
-- en base : le worldserver rejoue les fichiers de sql/updates a son demarrage, donc un objet deplace
-- a la main - par une commande de MJ comme par un UPDATE - revient a la valeur du fichier au
-- redemarrage suivant. Le vortex et le portail y sont revenus deux fois sans que rien ne le signale.
UPDATE `gameobject`
   SET `position_x` = -2256.00, `position_y` = -5441.74, `position_z` = 6192.98, `orientation` = 0,
       `rotation0` = -0.29250970, `rotation1` = 0.06972843,
       `rotation2` = 0, `rotation3` = 0.95371695
 WHERE `id` = 2600004;
-- Le vortex est un disque plat : incline de 35 degres vers le portail, cap 76,6 degres. Le
-- quaternion porte le tangage, que `orientation` ne sait pas exprimer - il n'est lu que depuis le
-- correctif de GameObject::Create, qui forcait le lacet et jetait rotation0..3.
UPDATE `gameobject`
   SET `position_x` = -2174.19, `position_y` = -5098.56, `position_z` = 6276.11, `orientation` = 1.37807,
       `rotation0` = 0, `rotation1` = 0, `rotation2` = SIN(1.37807/2), `rotation3` = COS(1.37807/2)
 WHERE `id` = 2600005;
