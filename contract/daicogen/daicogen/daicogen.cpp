#include "daicogen.hpp"

namespace daico {

	void daicogen::createico(const dataico& t) {
		
	//	require_auth(t.account); // make sure authorized by account

		eosio::action(
			eosio::permission_level /* (), */   {N(token),N(active)}, 
			N(token), N(create),
			std::make_tuple(N(token), t.token)
		).send();

		dataico_index daico(_self, _self); // code, scope

		daico.emplace(t.account /*payer*/, [&](auto& daicogen) {
			daicogen.account = t.account;
			daicogen.name = t.name;
			daicogen.description = t.description;
			daicogen.url = t.url;
			daicogen.whitepaper_url = t.whitepaper_url; 
			daicogen.token = t.token;
			daicogen.token_value = t.token_value;
			daicogen.soft_cap = t.soft_cap;
			daicogen.hard_cap = t.hard_cap;
			daicogen.start_date = t.start_date;
			daicogen.end_date = t.end_date;
			daicogen.charity_ico_percent = t.charity_ico_percent;
			daicogen.num_of_charities_distr = t.num_of_charities_distr;
			daicogen.charity_ico_duration = t.charity_ico_duration;
			daicogen.min_vote_turn_out = t.min_vote_turn_out;
			daicogen.min_vote_yes = t.min_vote_yes;
			daicogen.max_tap_increase = t.max_tap_increase;
			daicogen.tap_increase = t.tap_increase;
			daicogen.how_frequently = t.how_frequently;
			daicogen.max_num_refund = t.max_num_refund;
			daicogen.election_voting_duration = t.election_voting_duration;
			daicogen.min_vote_turn_out_r = t.min_vote_turn_out_r;
			daicogen.min_vote_yes_r = t.min_vote_yes_r;
		  });

		createvoting(t.account, "Cucomber");
	}
	
	void daicogen::removeico(const account_name account) {
		 
	//	 require_auth(account); // make sure authorized by account

		 dataico_index daico(_self, _self); // code, scope

		  // verify already exist
		  auto itr = daico.find(account);
		  eosio_assert(itr != daico.end(), "Daico for this account not found");
		  daico.erase( itr );
	}

	void daicogen::createvoting(const account_name icoaccount, const string proposal) {
		voting_index voting(_self, _self);

		voting.emplace(ico.account, [&](auto& vote) {
			vote.icocreator = icoaccount;
			vote.proposal = proposal;
			vote.yesvotes = 0;
			vote.novotes = 0;
		});
	}

	void daicogen::vote(const account_name icoaccount, const account_name voter, bool is_support) {
		voters_index voters(_self, _self);
		
		// add find-assert to prevent double voting
		if (is_support == true) {
			voters.emplace(icoaccount, [&](auto& vote) {
				vote.account = icoaccount;
				vote.is_support = is_support;
			});
		} else {
			voters.emplace(icoaccount, [&](auto& vote) {
				vote.account = icoaccount;
				vote.is_support = is_support;
			});
		}
			
	}

	void daicogen::apply(const account_name contract, const account_name act) {

		if (act == N(transfer)) {
			transferReceived(unpack_action_data<currency::transfer>(), contract);
			return;
		}

		auto &thiscontract = *this;

		switch (act) {
			EOSIO_API(daicogen,  (createico)(removeico))
		};
	}
 
	void daicogen::transferReceived(const currency::transfer &transfer, const account_name code) {
		if (transfer.from != N(daicogen))
		{
			if (transfer.to != _self) {
				return;
			}
			if (static_cast<uint32_t>(transfer.quantity.symbol == S(4, EOS)))
			{
				//eosio_assert(static_cast<uint32_t>(code == N(eosio.token)), "needs to come from eosio.token");
				//eosio_assert(static_cast<uint32_t>(transfer.memo.length() > 0), "needs a memo with the name");
				//eosio_assert(static_cast<uint32_t>(transfer.quantity.symbol == S(4, EOS)), "only EOS token allowed");
				//eosio_assert(static_cast<uint32_t>(transfer.quantity.is_valid()), "invalid transfer");
				//eosio_assert(static_cast<uint32_t>(transfer.quantity.amount >= 1000), "must be at least 0.1 EOS");
				
			}
		}	
	}
}

extern "C" {

	using namespace daico;
	using namespace eosio;

	void apply(uint64_t receiver, uint64_t code, uint64_t action) {
		auto self = receiver;
		daicogen contract(self);
		contract.apply(code, action);
		eosio_exit(0);
	}
}
