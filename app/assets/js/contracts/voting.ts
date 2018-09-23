export const getContract = async (eos: any) => {
  return await eos.contract('voting')
}

const JSEncrypt = require('node-jsencrypt')

const jsEncrypt = new JSEncrypt()

const publicKey =
`
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDa+S2Un0eKoLffD/YneaTyYjt
8lhXdZX+visaYZk+7i2lOYvt1VHyTd29UoD7XbN8l5MYJXrhvIyevuSJepbs8i9i
UQ7Qy11wn+qRRqCitwQolKDzsqi5OdE3UJPp3+ojCdd4AJq+iM4Ujy4W5IWBfWP7
zFqLON/F20/BY5SHeQIDAQAB
-----END PUBLIC KEY-----
`

jsEncrypt.setPublicKey(publicKey)

export type CreateVotingInput = {
  icoaccount: string,
  proposal: string
}

export type RemoveVotingInput = {
  account: string
}

export type VoteInput = {
  icoaccount: string,
  trvoter: string,
  idvoter: string,
  pick: boolean,
  currentVoter: string,
}

export type RemoveVoteInput = {
  icoaccount: string
}

export type CreateSuggestionInput = {
  icoaccount: string,
  from: string,
  to: string,
  pick: boolean
}

export type RemoveSuggestionInput = {
  from: string
}

const sleep = (milliseconds: number) => {
  return new Promise(resolve => setTimeout(resolve, milliseconds))
}

export const createVoting = (contract: any, app: any) => async (input: CreateVotingInput) => {
  await contract.createvoting(input, { authorization: "crowdsale" })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}

export const removeVoting = (contract: any, app: any) => async (input: RemoveVotingInput) => {
  await contract.removevoting(input, { authorization: "crowdsale" })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}

export const vote = (contract: any, app: any) => async (input: VoteInput) => {
  await contract.vote({ ...input, trvoter: jsEncrypt.encrypt(input.trvoter), pick: input.pick ? 1 : 0 }, { authorization: [ "crowdsale", "idaccount", input.currentVoter ] })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}

// bugbug
export const removeVote = (contract: any, app: any) => async (input: RemoveVoteInput) => {
  await contract.removevote(input, { authorization: "crowdsale" })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}

export const createSuggestion = (contract: any, app: any) => async (input: CreateSuggestionInput) => {
  const encryptedTo = jsEncrypt.encrypt(input.to)
  await contract.createsugg({ ...input, to: encryptedTo, pick: input.pick ? 1 : 0 }, { authorization: "crowdsale" })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}

export const removeSuggestion = (contract: any, app: any) => async (input: RemoveSuggestionInput) => {
  await contract.removesugg(input, { authorization: "crowdsale" })
  await sleep(1000)
  app.ports.transactionComplete.send(null)
}
