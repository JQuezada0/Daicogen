module DaicoTemplate.Model exposing (..)

type Msg
  = UpdateFormSection FormSection
  | UpdateDetail UpdateDetailMsg
  | UpdateTokenSale UpdateTokenSaleMsg
  | UpdateVoting UpdateVotingMsg
  | UpdateCharity UpdateCharityMsg
  | SubmitTemplate
  | Reload

type UpdateDetailMsg
  = UpdateName String
  | UpdateDescription String
  | UpdateUrl String
  | UpdateWhitepaperUrl String

type UpdateTokenSaleMsg
  = UpdateTokenName String
  | UpdateTokenSymbol String
  | UpdateTokenSupply String
  | UpdateTokenValue Int
  | UpdateSoftCap Int
  | UpdateHardCap Int
  | UpdateStartDate Float
  | UpdateEndDate Float

type UpdateVotingMsg
  = UpdateTapMinimumTurnout Float
  | UpdateTapThreshold Float
  | UpdateTapMaxIncrease Float
  | UpdateTapVoteDuration Float
  | UpdateRefundElectionFrequency Float
  | UpdateRefundMaxElections Int
  | UpdateRefundVotingDuration Float
  | UpdateRefundMinimumTurnout Float
  | UpdateRefundThreshold Float

type UpdateCharityMsg
  = UpdateAllocation Float
  | UpdateNumberOfCharities Int
  | UpdateDuration Float

type FormSection
  = Description
  | Tokensale
  | Funding
  | Voting
  | Charity

type alias Model =
  {
    activeFormSection : FormSection,
    template : Template
  }

type alias Template = {
  description: DescriptionParams,
  tokenSale: TokenSaleParams,
  voting: VotingParams,
  charity: CharityParams,
  funding: FundingParams
}

type alias DescriptionParams = {
  name: String,
  description: String,
  url: String,
  whitepaperUrl: String
}

type alias TokenSaleParams = {
  tokenName: String,
  tokenSymbol: String,
  tokenSupply: String,
  tokenValue: Int,
  tokenSaleAllocation: String,
  softCap: Int,
  hardCap: Int,
  startDate: Float,
  endDate: Float
}

type alias VotingParams = {
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
}

type alias CharityParams = {
  allocation: Float,
  numberOfCharities: Int,
  duration: Float
}

type alias FundingParams = {
  tokenSaleStart: Float,
  fundingCyclePeriod: Float,
  initialTap: String
}