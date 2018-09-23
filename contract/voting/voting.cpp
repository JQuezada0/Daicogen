#include "voting.hpp"

namespace vote {

	// need to update remove of suggestions by other key
	void voting::removesugg(const account_name from) {
		 
	//	 require_auth(account); // make sure authorized by account

		 sugg_index sugg(_self, _self); // code, scope

		  // verify already exist
		  auto itr = sugg.find(from);
		  eosio_assert(itr != sugg.end(), "Suggestions for this account not found");
		  sugg.erase( itr );
	}

	void voting::createsugg(const account_name icoaccount, const account_name from, const string to, string pick) {
		sugg_index sugg(_self, _self); // code, scope

		sugg.emplace(icoaccount, [&](auto& suggestions) {
			suggestions.iconame = icoaccount;
			suggestions.from = from;
			suggestions.to = to;
			suggestions.pick = pick;
		});
	}

	void voting::removevoting(const account_name account) {
		 
	//	 require_auth(account); // make sure authorized by account

		 voting_index voting(_self, _self); // code, scope

		  // verify already exist
		  auto itr = voting.find(account);
		  eosio_assert(itr != voting.end(), "Voting for this account not found");
		  voting.erase( itr );
	}

	void voting::createvoting(const account_name icoaccount, const string proposal) {
		voting_index voting(_self, _self);

		voting.emplace(icoaccount, [&](auto& vote) {
			vote.icocreator = icoaccount;
			vote.proposal = proposal;
			vote.yesvotes = 0;
			vote.novotes = 0;
		});
	}

	void voting::vote(const account_name icoaccount, const account_name idvoter, const account_name trvoter, bool pick) {
		votes_index votes(_self, _self);
		voters_index voters(_self, _self);

		
		// add find-assert to prevent double voting
		if (trvoter != idvoter) {
			votes.emplace(icoaccount, [&](auto& vote) {
				vote.iconame = icoaccount;
				vote.votername = trvoter;
				vote.pick = pick;
			});
		}
		else {
			votes.emplace(icoaccount, [&](auto& vote) {
				vote.iconame = icoaccount;
				vote.votername = idvoter;
				vote.pick = pick;
			});
		}
		

		auto itr = voters.find(idvoter);
		eosio_assert(itr == voters.end(), "This idvoter is already voted");
		voters.emplace(idvoter, [&](auto& vote){
			vote.account = idvoter;
			vote.is_voted = true;
		});
		if (trvoter != idvoter) {
			auto itr = voters.find(trvoter);
			eosio_assert(itr == voters.end(), "This trvoter is already voted");
			voters.emplace(trvoter, [&](auto& vote){
				vote.account = trvoter;
				vote.is_voted = true;
			});
		}
	}

	// need to update remove of vote by other key
	void voting::removevote(const account_name icoaccount) {
		votes_index votes(_self, _self);

		  // verify already exist
		  auto itr = votes.find(icoaccount);
		  eosio_assert(itr != votes.end(), "Voter for this account not found");
		  votes.erase( itr );
	}

	void voting::apply(const account_name contract, const account_name act) {

		// if (act == N(transfer)) {
			// transferReceived(unpack_action_data<currency::transfer>(), contract);
			// return;
		// }

		auto &thiscontract = *this;

		switch (act) {
			EOSIO_API(voting,  (createvoting)(removevoting)(vote)(removevote)(createsugg)(removesugg))
		};
	}
 
}

extern "C" {

	using namespace vote;
	using namespace eosio;

	void apply(uint64_t receiver, uint64_t code, uint64_t action) {
		auto self = receiver;
		voting contract(self);
		contract.apply(code, action);
		eosio_exit(0);
	}
}
