port module Ports exposing (..)

port submitTemplate :
  {
    description: {
      name: String,
      description: String,
      url: String,
      whitepaperUrl: String
    },
    tokenSale: { 
      tokenName: String,
      tokenSymbol: String,
      tokenSupply: String,
      tokenValue: Int,
      tokenSaleAllocation: String,
      softCap: Int,
      hardCap: Int,
      startDate: Float,
      endDate: Float
    },
    voting: {
      tapPoll: {
        minimumTurnout: Float,
        threshold: Float,
        maxTapIncrease: Float,
        voteDuration: Float
      },
      refundPoll: {
        refundElectionFrequency: Float,
        maxElections: Int,
        votingDuration: Float,
        minimumTurnout: Float,
        threshold: Float
      }
    },
    charity: {
      allocation: Float,
      numberOfCharities: Int,
      duration: Float
    },
    funding: {
      tokenSaleStart: Float,
      fundingCyclePeriod: Float,
      initialTap: String
    }
  } -> Cmd msg

port createVoting : {
  icoaccount: String,
  proposal: String
} -> Cmd msg

port removeVoting : {
  account: String
} -> Cmd msg

port vote : {
  icoaccount: String,
  idvoter: String,
  trvoter: String,
  currentVoter: String,
  pick: Bool
} -> Cmd msg

port removeVote : {
  icoaccount: String
} -> Cmd msg

port createSuggestion : {
  icoaccount: String,
  from: String,
  to: String,
  pick: Bool
} -> Cmd msg

port removeSuggestion : {
  from: String
} -> Cmd msg

port transactionComplete : (() -> msg) -> Sub msg