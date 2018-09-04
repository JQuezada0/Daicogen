#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
using namespace eosio;

class hello : public eosio::contract {
  public:
      using contract::contract;

      struct testValue {
          uint64_t     id;
          uint64_t     value = 0;
          account_name owner;
      };

      /// @abi action
      void hi( account_name user ) {
        print("Hello, ", name{user});
      }

    struct test_table {
        uint64_t     id;
        uint64_t     value = 0;
        account_name owner;

        auto primaryKey()const { return id; }
        uint64_t getValue()const { return value; }
        account_name getOwner()const { return owner; }

        EOSLIB_SERIALIZE( test_table, (id)(value)(owner) )
    };

    eosio::multi_index<
            N(test), // Name of the table
            test_table, // Struct that represents the table
            indexed_by<N(id), const_mem_fun<test_table, uint64_t, &test_table::primaryKey>>, // Query by id
            indexed_by<N(value), const_mem_fun<test_table, uint64_t, &test_table::getValue>>, // Query by value
            indexed_by<N(owner), const_mem_fun<test_table, uint64_t, &test_table::getOwner>> // Query by owner
    > tests(N(h), N(t));

    /// @abi action
    void insert(testValue val) {
      auto res = tests.emplace()
    }
};

EOSIO_ABI( hello, (hi) )
