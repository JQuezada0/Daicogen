#pragma once

#include <eosiolib/eosio.hpp>
#include <string>

using namespace eosio;

using std::string;

namespace coinstarter {
  class crowdfund : public contract {
  public:
    crowdfund(account_name self);

    struct campaigninput {
      account_name	creator;
      /* category details */
      string				category;

      /* project details */
      string				project_title;
      string				description;
      string				image;

      /* campaign details */
      uint64_t			funding_goal;
      uint64_t			campaign_start;
      uint64_t			campaign_end;

      /* reward details */
      string        title;
      uint64_t			pledge_amount;
      string			  reward_description;
      uint64_t			estimated_delivery;

      EOSLIB_SERIALIZE( campaigninput, (creator)(category)(project_title)(description)(image)(funding_goal)(campaign_start)(campaign_end)(title)(pledge_amount)(reward_description)(estimated_delivery) )
    };

    [[eosio::action]]
    void ccampaign(const campaigninput input);

    [[eosio::action]]
    void rcampaign(const uint64_t campaignId);

  private:
    struct [[eosio::table]] campaign {
      uint64_t			id;
      account_name	creator;
      /* category details */
      string				category;

      /* project details */
      string				project_title;
      string				description;
      string				image;

      /* campaign details */
      uint64_t			funding_goal;
      uint64_t			campaign_start;
      uint64_t			campaign_end;

      /* reward details */
      string        title;
      uint64_t			pledge_amount;
      string			  reward_description;
      uint64_t			estimated_delivery;

      uint64_t primary_key() const { return id; }
    };

    typedef multi_index<N(campaign), campaign> campaignDatastore;

    campaignDatastore campaigns;
  };
}

