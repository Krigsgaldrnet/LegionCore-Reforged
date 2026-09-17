-- Le skybox M2 n'etait pas dessine : HighlightSky restait a 0 sur les deux parametres de ciel clair
-- de Quel'Thalas, valeur recopiee de l'original. Les deux correctifs de ciel qui fonctionnent -
-- Drustvar 901 et Elwynn 3704 - le mettent a 1 sur leur parametre clair. 442 l'avait deja.
DELETE FROM `light_params` WHERE `ID` IN (399, 433);
INSERT INTO `light_params` (`Glow`, `WaterShallowAlpha`, `WaterDeepAlpha`, `OceanShallowAlpha`, `OceanDeepAlpha`,
                            `OverrideCelestialSphere1`, `OverrideCelestialSphere2`, `OverrideCelestialSphere3`,
                            `LightSkyboxID`, `HighlightSky`, `CloudTypeID`, `Flags`, `ID`, `VerifiedBuild`) VALUES
(0.5, 0.5, 1, 0.5,  1, 0, 0, 0, 902, 1, 0, 0, 399, 26972),
(0.5, 0.5, 1, 0.75, 1, 0, 0, 0, 902, 1, 0, 0, 433, 26972);
UPDATE `world_legion`.`version` SET `hotfix_cache_id` = 44;
