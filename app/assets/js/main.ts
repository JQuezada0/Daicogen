import * as Elm from "./elm"
import * as Crowdfund from "./contracts/crowdfund"

const Eos = require('eosjs')
const accounts = require('../../accounts.json')

const keyProvider = [
  accounts.master.owner.privateKey, 
  accounts.master.active.privateKey,
  accounts.crowdfund.owner.privateKey,
  accounts.crowdfund.active.privateKey,
  "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3" // eosio
]

const eos = Eos({httpEndpoint: "http://localhost:8888",chainId: "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",  keyProvider})

const main = async () => {
  const app = Elm.Main.embed(document.getElementById("main"))
  await createAccountIfNotExists("eosio", "master")
  await createAccountIfNotExists("master", "crowdfund")

  const crowdfundContract = await Crowdfund.getContract(eos)

  app.ports.submitCampaign.subscribe(Crowdfund.createCampaign(crowdfundContract))
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