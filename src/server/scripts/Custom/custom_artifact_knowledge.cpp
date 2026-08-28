/*
 * Connaissance des armes prodigieuses - contenu custom (non-retail)
 *
 * Quete de rattrapage pour les rerolls : rendre la quete porte la Connaissance du personnage
 * au rang 10 d'un coup. La disponibilite de la quete est filtree cote SQL par la table
 * `conditions` (niveau max + CONDITION_ACCOUNT_ARTIFACT_KNOWLEDGE : le compte doit deja posseder
 * un personnage niveau max ayant au moins 25 rangs de Connaissance).
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "DB2Stores.h"

enum ArtifactKnowledgeCatchup
{
    QUEST_ARTIFACT_KNOWLEDGE_CATCHUP = 316999,
    ARTIFACT_KNOWLEDGE_CATCHUP_RANK  = 10
};

class player_artifact_knowledge_catchup : public PlayerScript
{
public:
    player_artifact_knowledge_catchup() : PlayerScript("player_artifact_knowledge_catchup") {}

    void OnQuestReward(Player* player, Quest const* quest) override
    {
        if (!player || !quest || quest->GetQuestId() != QUEST_ARTIFACT_KNOWLEDGE_CATCHUP)
            return;

        uint32 knowledgeLevel = player->GetCurrency(CURRENCY_TYPE_ARTIFACT_KNOWLEDGE);
        if (knowledgeLevel >= ARTIFACT_KNOWLEDGE_CATCHUP_RANK)
            return;

        uint32 precision = uint32(sDB2Manager.GetCurrencyPrecision(CURRENCY_TYPE_ARTIFACT_KNOWLEDGE));
        player->ModifyCurrency(CURRENCY_TYPE_ARTIFACT_KNOWLEDGE, (ARTIFACT_KNOWLEDGE_CATCHUP_RANK - knowledgeLevel) * precision);
    }
};

void AddSC_custom_artifact_knowledge()
{
    new player_artifact_knowledge_catchup();
}
