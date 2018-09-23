enum VotingAction {
  CreateVoting = "voting::createvoting",
  RemoveVoting = "voting::removevoting",
  Vote = "voting::vote",
  RemoveVote = "voting::removevote",
  CreateSuggestion = "voting::createsugg",
  RemoveSuggestion = "voting::removesugg"
}

enum TokenSaleAction {
  CreateTokenSale = "crowdsale::createico",
  RemoveTokenSale = "crowdsale::removeico"
}

type CreateVotingPayload = {
  icoaccount: string,
  proposal: string
}

type RemoveVotingPayload = {
  account: string
}

type VotePayload = {
  icoaccount: string,
  idvoter: string,
  trvoter: string,
  pick: boolean
}

type RemoveVotePayload = {
  icoaccount: string
}

type CreateSuggestionPayload = {
  icoaccount: string,
  from: string,
  to: string,
  pick: string
}

type RemoveSuggestionPayload = {
  from: string
}

type CreateTokensalePayload = {
  t: {
    account: string,
    name: string,
    description: string,
    url: string,
    whitepaper_url: string,
    token: string,
    token_value: number,
    raised: number,
    issued: number,
    soft_cap: number,
    hard_cap: number,
    start_date: number,
    end_date: number,
    charity_ico_percent: number,
    num_of_charities_distr: number,
    charity_ico_duration: number,
    min_vote_turn_out: number,
    min_vote_yes: number,
    max_tap_increase: number,
    tap_increase: number,
    how_frequently: number,
    max_num_refund: number,
    election_voting_duration: number,
    min_vote_turn_out_r: number,
    min_vote_yes_r: number
  }
}

type RemoveTokensalePayload = {
  account: string
}

const updateVoting = (votingAction: VotingAction) => (state: any, payload: any, blockInfo: any, context: any) => {
  switch (votingAction) {
    case VotingAction.CreateVoting:
      createVoting(state, payload.data)
      break
    case VotingAction.RemoveVoting:
      removeVoting(state, payload.data)
      break
    case VotingAction.Vote:
      vote(state, payload.data)
      break
    case VotingAction.RemoveVote:
      removeVote(state, payload.data)
      break
    case VotingAction.CreateSuggestion:
      createSuggestion(state, payload.data)
      break
    case VotingAction.RemoveSuggestion:
      removeSuggestion(state, payload.data)
      break
  }
}

const updateTokensale = (tokensaleAction: TokenSaleAction) => (state: any, payload: any, blockInfo: any, context: any) => {
  switch (tokensaleAction) {
    case TokenSaleAction.CreateTokenSale:
      createTokenSale(state, payload.data)
      break
    case TokenSaleAction.RemoveTokenSale:
      removeTokenSale(state, payload.data)
      break
  }
}

const createTokenSale = (state: any, payload: CreateTokensalePayload) => {
  const args = payload.t
  state.project.insert({ 
    owner: args.account,
    name: args.name,
    description: args.description,
    url: args.url,
    whitepaperUrl: args.whitepaper_url,
    tapVoterTurnout: args.min_vote_turn_out,
    tapThreshold: args.min_vote_yes,
    tapMaxIncrease: args.max_tap_increase,
    tapVoteDuration: args.election_voting_duration,
    refundFrequency: args.how_frequently,
    maxNumRefunds: args.max_num_refund,
    refundVoteDuration: 0,
    refundVoterTurnout: args.min_vote_turn_out_r,
    refundThreshold: args.min_vote_yes_r,
   })
}

const removeTokenSale = (state: any, payload: RemoveTokensalePayload) => {
  state.project.destroy({ owner: payload.account })
}

const createVoting = (state: any, payload: CreateVotingPayload) => {
  state.poll.insert({ icocreator: payload.icoaccount, proposal: payload.proposal, yesvotes: 0, novotes: 0 })
}

const removeVoting = (state: any, payload: RemoveVotingPayload) => {
  state.poll.destroy({ icocreator: payload.account })
}

const vote = (state: any, payload: VotePayload) => {
  state.vote.insert({ iconame: payload.icoaccount, idvoter: payload.idvoter, trvoter: payload.trvoter, pick: payload.pick ? true : false })
}

const removeVote = (state: any, payload: RemoveVotePayload) => {
  state.vote.destroy({  }) // bugbug
}

const createSuggestion = (state: any, payload: CreateSuggestionPayload) => {
  state.vote_proposal.insert({ iconame: payload.icoaccount, from: payload.from, to: payload.to, pick: payload.pick ? true : false })
}

const removeSuggestion = (state: any, payload: RemoveSuggestionPayload) => {
  state.vote_proposal.destroy({ from: payload.from })
}

const updaters = [
  {
    actionType: VotingAction.CreateVoting,
    updater: updateVoting(VotingAction.CreateVoting),
  },
  {
    actionType: VotingAction.RemoveVoting,
    updater: updateVoting(VotingAction.RemoveVoting),
  },
  {
    actionType: VotingAction.Vote,
    updater: updateVoting(VotingAction.Vote),
  },
  {
    actionType: VotingAction.RemoveVote,
    updater: updateVoting(VotingAction.RemoveVote),
  },
  {
    actionType: VotingAction.CreateSuggestion,
    updater: updateVoting(VotingAction.CreateSuggestion),
  },
  {
    actionType: VotingAction.RemoveSuggestion,
    updater: updateVoting(VotingAction.RemoveSuggestion),
  },
  {
    actionType: TokenSaleAction.CreateTokenSale,
    updater: updateTokensale(TokenSaleAction.CreateTokenSale)
  },
  {
    actionType: TokenSaleAction.RemoveTokenSale,
    updater: updateTokensale(TokenSaleAction.RemoveTokenSale)
  }
]

export default updaters