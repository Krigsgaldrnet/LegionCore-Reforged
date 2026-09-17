-- La Confluence temporelle devient un sanctuaire : plus de JcJ possible.
--
-- Ce n'est pas un type de carte - map.InstanceType ne connaît que continent, donjon, raid, champ de
-- bataille, arène et scénario. Le sanctuaire est un drapeau de zone : AREA_FLAG_SANCTUARY = 0x800,
-- lu dans Flags[0] par AreaTableEntry::IsSanctuary.
--
-- La ligne de correctif de la zone 15010 existe déjà (Id 9000482), donc rien à ajouter là : il
-- suffit que le client redemande l'enregistrement, d'où l'incrément du cache.
UPDATE `area_table` SET `Flags1` = `Flags1` | 0x800 WHERE `ID` = 15010;

UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 89;
