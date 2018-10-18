#include "crowdfund.hpp"

#include <eosiolib/eosio.hpp>

using namespace eosio;
using std::string;

namespace coinstarter {

  crowdfund::crowdfund( account_name s )
  :contract(s),
  campaigns(_self, _self)
  {};

  void crowdfund::ccampaign(const campaigninput input) {
    campaigns.emplace(_self, [&](campaign& newCampaign) {
      newCampaign.id = campaigns.available_primary_key();
      newCampaign.creator = input.creator;
      newCampaign.category = input.category;
      newCampaign.project_title = input.project_title;
      newCampaign.description = input.description;
      newCampaign.image = input.image;
      newCampaign.funding_goal = input.funding_goal;
      newCampaign.campaign_start = input.campaign_start;
      newCampaign.campaign_end = input.campaign_end;
      newCampaign.title = input.title;
      newCampaign.pledge_amount = input.pledge_amount;
      newCampaign.reward_description = input.reward_description;
      newCampaign.estimated_delivery = input.estimated_delivery;
    });
  }

  void crowdfund::rcampaign(const uint64_t campaignId) {
    auto itr = campaigns.find(campaignId);
    if (itr != campaigns.end())
    {
      campaigns.erase(itr);
    }
  }

  EOSIO_ABI( crowdfund, (ccampaign) (rcampaign) )
}
