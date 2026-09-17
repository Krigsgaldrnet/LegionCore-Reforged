-- The world map follows the timeline too.
--
-- Pressing M in the Wound still drew the Silithus of 2006, because nothing ever told the client to
-- swap the map art. The phase shift packet carries a field for exactly this - PhaseData::
-- SendPhaseshiftToPlayer pushes uiWmAreaId into UiWorldMapAreaIds - and phase_definitions has the
-- column feeding it, UiWorldMapAreaID, which was left at 0 everywhere.
--
-- Blizzard authored the second map: WorldMapArea 261 is "Silithus", 1206 is "Silithus_terrain1",
-- same map and same area, flagged 0x2. The suffix is their convention for a phased variant, not a
-- guess - thirteen rows carry it, Hyjal_terrain1, Uldum_terrain1, Dustwallow_terrain1 and the rest,
-- every one of them flagged 0x2. So the art exists in the client and only had to be asked for.
--
-- It is set on both definitions that mean "this player stands in the Wound": entry 10 for Silithus
-- itself, and entry 4600, the one given to every zone of Kalimdor so the swap survives crossing a
-- border. Looking at Silithus from Un'Goro then shows the Wound as well, which is the same answer
-- the ground already gives.
--
-- The two SET statements exist because the file has to stay readable: entries 11 to 15 are the old
-- zone and the questline sub-states, and none of them is touched.

UPDATE `phase_definitions` SET `UiWorldMapAreaID` = 1206 WHERE `zoneId` = 1377 AND `entry` = 10;
UPDATE `phase_definitions` SET `UiWorldMapAreaID` = 1206 WHERE `entry` = 4600;
