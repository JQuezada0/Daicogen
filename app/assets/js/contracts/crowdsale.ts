export const getContract = async (eos: any) => {
  return await eos.contract('crowdsale')
}

type CreateIcoInput = {
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

type RemoveIcoInput = {
  account: string
}

export const createIco = async (contract: any, input: CreateIcoInput) => {
  await contract.createico({ t: input }, { authorization: "crowdsale" })
}

export const removeIco = async (contract: any, input: RemoveIcoInput) => {
  await contract.removeico(input), { authorization: "crowdsale" }
}