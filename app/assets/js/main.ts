import * as Elm from "./elm"
import * as Crowdsale from "./contracts/crowdsale"
import * as Voting from "./contracts/voting"

const Eos = require('eosjs')
const accounts = require('../../accounts.json')

const keyProvider = [
  accounts.master.owner.privateKey, 
  accounts.master.active.privateKey,
  accounts.crowdsale.owner.privateKey,
  accounts.crowdsale.active.privateKey,
  accounts.voting.active.privateKey,
  accounts.voting.owner.privateKey,
  accounts.token.owner.privateKey,
  accounts.token.active.privateKey,
  accounts.idaccount.owner.privateKey,
  accounts.idaccount.active.privateKey,
  accounts.delegate.owner.privateKey,
  accounts.delegate.active.privateKey,
  "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
]
const eos = Eos({httpEndpoint: "http://localhost:8888",chainId: "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",  keyProvider})

const main = async () => {
  const app = Elm.Main.embed(document.getElementById("main"))
  await createAccountIfNotExists("eosio", "master")
  await createAccountIfNotExists("master", "crowdsale")
  await createAccountIfNotExists("master", "voting")
  await createAccountIfNotExists("crowdsale", "token")
  await createAccountIfNotExists("master", "idaccount")
  await createAccountIfNotExists("master", "delegate")

  const crowdsaleContract = await Crowdsale.getContract(eos)
  const votingContract = await Voting.getContract(eos)

  app.ports.submitTemplate.subscribe(submitTemplate(crowdsaleContract, votingContract, app))
  app.ports.createVoting.subscribe(Voting.createVoting(votingContract, app))
  app.ports.removeVoting.subscribe(Voting.removeVoting(votingContract, app))
  app.ports.vote.subscribe(Voting.vote(votingContract, app))
  app.ports.removeVote.subscribe(Voting.removeVote(votingContract, app))
  app.ports.createSuggestion.subscribe(Voting.createSuggestion(votingContract, app))
  app.ports.removeSuggestion.subscribe(Voting.removeSuggestion(votingContract, app))
}

document.addEventListener("DOMContentLoaded", main);

const createAccountIfNotExists = async (creator: string, accountName: string) => {
  try {
    await eos.getAccount(accountName)
  } catch (error) {
    eos.transaction((tr: any) => {
      tr.newaccount({
        creator: creator,
        name: accountName,
        owner: accounts[accountName].owner.publicKey,
        active: accounts[accountName].active.publicKey
      })
    })
  }
}

const submitTemplate = (contract: any, votingContract: any, app: any) => async (params: any) => {
  await Crowdsale.createIco(contract,
    {
      account: "crowdsale",
      name: params.description.name,
      description: params.description.description,
      url: params.description.url,
      whitepaper_url: params.description.whitepaperUrl, // 100000.0000 ISOS
      token: `${String(params.tokenSale.tokenSupply)}.0000 ${String(params.tokenSale.tokenSymbol)}`,
      token_value: params.tokenSale.tokenValue,
      soft_cap: params.tokenSale.softCap,
      hard_cap: params.tokenSale.hardCap,
      start_date: params.tokenSale.startDate,
      end_date: params.tokenSale.endDate,
      charity_ico_percent: params.charity.allocation,
      num_of_charities_distr: params.charity.numberOfCharities,
      charity_ico_duration: params.charity.duration, 
      min_vote_turn_out: params.voting.tapPoll.minimumTurnout,
      min_vote_yes: params.voting.tapPoll.threshold,
      max_tap_increase: params.voting.tapPoll.maxTapIncrease,
      tap_increase: 0, // params.voting.tapPoll.voteDuration,
      how_frequently: params.voting.refundPoll.refundElectionFrequency,
      max_num_refund: params.voting.refundPoll.maxElections,
      election_voting_duration: params.voting.refundPoll.votingDuration,
      min_vote_turn_out_r: params.voting.refundPoll.minimumTurnout,
      min_vote_yes_r: params.voting.refundPoll.threshold,
      raised: 0,
      issued: 0
    })
  await Voting.createVoting(votingContract, app)({
    icoaccount: "crowdsale",
    proposal: "FundsPerCycle"
  })
}