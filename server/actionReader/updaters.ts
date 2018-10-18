enum CrowdFundAction {
  CreateCampaign = "crowdfund::ccampaign",
  RemoveCampaign = "crowdfund::rcampaign"
}

type CreateCampaignPayload = {
  input: {
    creator: string,
    category: string,
    project_title: string,
    description: string,
    image: string,
    funding_goal: number,
    campaign_start: number,
    campaign_end: number,
    title: string,
    pledge_amount: number,
    reward_description: string,
    estimated_delivery: string
  }
}

type RemoveCampaignPayload = {
  campaignId: number
}

const updateCrowdFund = (action: CrowdFundAction) => (state: any, payload: any, blockInfo: any, context: any) => {
  switch (action) {
    case CrowdFundAction.CreateCampaign:
      createCampaign(state, payload.data)
      break
    case CrowdFundAction.RemoveCampaign:
      removeCampaign(state, payload.data)
      break
  }
}

const createCampaign = (state: any, payload: CreateCampaignPayload) => {
  state.campaign.insert(payload.input)
}

const removeCampaign = (state: any, payload: RemoveCampaignPayload) => {
  state.campaign.destroy({ id: payload.campaignId })
}

const updaters = [
  {
    actionType: CrowdFundAction.CreateCampaign,
    updater: updateCrowdFund(CrowdFundAction.CreateCampaign),
  },
  {
    actionType: CrowdFundAction.RemoveCampaign,
    updater: updateCrowdFund(CrowdFundAction.RemoveCampaign),
  },
]

export default updaters