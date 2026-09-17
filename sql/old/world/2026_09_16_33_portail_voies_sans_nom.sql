-- Le portail des Voies du temps ne porte aucun nom : rien ne doit s'afficher au survol, seul le
-- clic compte. Un nom vide laisse le client surligner l'objet et proposer le clic, sans infobulle.
UPDATE `gameobject_template` SET `name` = '' WHERE `entry` = 2600050;
