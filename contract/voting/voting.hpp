#pragma once

#include <eosiolib/eosio.hpp>
#include <eosiolib/singleton.hpp>
#include <string>

using namespace eosio;


namespace vote {

	using std::string;
	using eosio::indexed_by;
	using eosio::const_mem_fun;
	using std::string;

	class voting : public contract {
	public:
		voting(account_name self) :contract(self) {}

		
		
		// @abi table
		struct voters {	
			account_name		account;
			bool				is_voted;

			uint64_t primary_key() const { return account; }

			EOSLIB_SERIALIZE( voters, (account)(is_voted))
		};
		typedef multi_index<N(voters), voters> voters_index;

		// @abi table
		struct votes {	
			account_name		iconame;
			account_name		votername;
			bool				pick;

			uint64_t primary_key() const { return votername; }

			EOSLIB_SERIALIZE( votes, (iconame)(votername)(pick))
		};
		typedef multi_index<N(votes), votes> votes_index;
	
		// @abi table
		struct sugg {
			account_name	iconame;
			account_name	from;
			account_name	to;
			bool			pick;

			uint64_t primary_key() const { return iconame; }
			EOSLIB_SERIALIZE(sugg, (iconame)(from)(to)(pick))
		};
		typedef multi_index<N(sugg), sugg> sugg_index;


		// @abi table
		struct votingdata {
   			account_name  icocreator;
  			string    proposal;
  			uint64_t   yesvotes;
 			uint64_t   novotes;
  
			uint64_t primary_key() const { return icocreator; }

			EOSLIB_SERIALIZE( votingdata, (icocreator)(proposal)(yesvotes)(novotes))
		};
		typedef multi_index<N(votingdata), votingdata> voting_index;



		// @abi action
		void createvoting(const account_name icoaccount, const string proposal);
		// @abi action
		void removevoting(const account_name account);
		// @abi action
		void vote(const account_name icoaccount, const account_name trvoter, const account_name idvoter, bool pick);
		// @abi action
		void removevote(const account_name icoaccount);
		// @abi action
		void createsugg(const account_name icoaccount, const account_name from, const account_name to, bool pick);
		// @abi action
		void removesugg(const account_name from);

		void apply(const account_name contract, const account_name act);

		/*typedef singleton<N(config), config> configs;
		typedef singleton<N(icoconfig), icoconfig> icoconfigs;
*//*
		typedef multi_index<N(oracle), oracle> oracles;
		typedef multi_index<N(log), log> logs;
		typedef multi_index<N(purchase), purchase> purchases;
	*/
	}; 
}

//EOSIO_ABI(daico::daicogen, (setapp)(setico)(addauser)(addausers)(delauser)(delall)(logdata)(dellogdata)(addpurchase))

