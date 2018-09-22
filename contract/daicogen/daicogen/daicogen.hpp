#pragma once

#include <eosiolib/eosio.hpp>
#include <eosiolib/singleton.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/currency.hpp>
#include "../token/token.hpp" 
#include <string>

using namespace eosio;


namespace daico {

	using std::string;
	using eosio::indexed_by;
	using eosio::const_mem_fun;
	using std::string;
	using eosio::asset;

	class daicogen : public contract {
	public:
		daicogen(account_name self) :contract(self) {}


		// @abi table
		struct dataico {
			
			account_name		account;
		/* description */
			string				name;
			string				description;
			string				url;
			string				whitepaper_url;
		/* token */
			asset				token;
			uint64_t			token_value;
		/* token sale */
			uint64_t			raised;
			uint64_t			issued;
			uint32_t			soft_cap;
			uint32_t			hard_cap;
			uint32_t			start_date;
			uint64_t			end_date;
		 /* funding */
			uint32_t			charity_ico_percent;
			uint32_t			num_of_charities_distr;
			uint32_t			charity_ico_duration;
		  /* voting */
		  /*tap poll*/
			uint32_t			min_vote_turn_out;
			uint32_t			min_vote_yes;
			uint32_t			max_tap_increase;
			uint32_t			tap_increase;
		  /*refund poll */
			uint32_t			how_frequently;
			uint32_t			max_num_refund;
			uint32_t			election_voting_duration;
			uint32_t			min_vote_turn_out_r;
			uint32_t			min_vote_yes_r;

			uint64_t primary_key() const { return account; }

			EOSLIB_SERIALIZE( dataico, (account)(name)(description)(url)(whitepaper_url)(token)(token_value)(raised)(issued)(soft_cap)(hard_cap)(start_date)(end_date)(charity_ico_percent)(num_of_charities_distr)(charity_ico_duration)(min_vote_turn_out)(min_vote_yes)(max_tap_increase)(tap_increase)(how_frequently)(max_num_refund)(election_voting_duration)(min_vote_turn_out_r)(min_vote_yes_r) )
		};
		typedef multi_index<N(dataico), dataico> dataico_index;

		

		
		// @abi table
		struct voters {	
			account_name		account;
			bool				is_support;

			uint64_t primary_key() const { return account; }

			EOSLIB_SERIALIZE( voters, (account)(is_support))
		};
		typedef multi_index<N(voters), voters> voters_index;
	

		// @abi table
		struct voting {
   			account_name  icocreator;
  			string    proposal;
  			uint64_t   yesvotes;
 			uint64_t   novotes;
  
			uint64_t primary_key() const { return icocreator; }

			EOSLIB_SERIALIZE( voting, (icocreator)(yesvotes)(novotes))
		};
		typedef multi_index<N(voting), voting> voting_index;



		// @abi action
		void createico(const dataico& t);

		//@abi action
		void removeico(const account_name account);
		
		void apply(const account_name contract, const account_name act);

		void transferReceived(const currency::transfer &transfer, const account_name code);

		// @abi action
		void createvoting(const dataico& ico, const string proposal);

		// @abi action
		void createvoting(const dataico& ico, const string proposal);

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

