#include <eosiolib/eosio.hpp>
using namespace eosio;

class hello : public eosio::contract {
  public:
      using contract::contract;

      /// @abi action 
      void hi( account_name user ) {
         print( "Hello, ", name{user} );
      }

    struct test_table {
        uint64_t     id;
        uint64_t     value = 0;
        account_name owner;

        auto primary_key()const { return id; }
        uint64_t getValue()const { return value; }
        account_name get_owner()const { return owner; }

        EOSLIB_SERIALIZE( test_table, (id)(value)(owner) )
    };
};

EOSIO_ABI( hello, (hi) )
