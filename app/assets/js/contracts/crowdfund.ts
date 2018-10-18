export const getContract = async (eos: any) => {
  return await eos.contract('crowdfund')
}

export type CreateCampaignInput = {
  categoryDetails: {
    category: string
  },
  projectDetails: {
    title: string,
    description: string,
    image: string,
  },
  campaignDetails: {
    fundingGoal: number,
    campaignStart: number,
    campaignEnd: number
  },
  rewardDetails: {
    title: string,
    pledgeAmount: number,
    description: string,
    estimatedDelivery: number
  }
}

type RemoveCrowdfundInput = {
  id: number
}

export const createCampaign = (contract: any) => async (input: CreateCampaignInput) => {
  await contract.ccampaign({ input: {
    creator: "crowdfund",
    category: input.categoryDetails.category,
    project_title: input.projectDetails.title,
    description: input.projectDetails.description,
    image: input.projectDetails.image,
    funding_goal: input.campaignDetails.fundingGoal,
    campaign_start: input.campaignDetails.campaignStart,
    campaign_end: input.campaignDetails.campaignEnd,
    title: input.rewardDetails.title,
    pledge_amount: input.rewardDetails.pledgeAmount,
    reward_description: input.rewardDetails.description,
    estimated_delivery: input.rewardDetails.estimatedDelivery,
  } }, { authorization: "crowdfund" })
}

export const removeCrowdfund = async (contract: any, input: RemoveCrowdfundInput) => {
  await contract.rcampaign(input.id - 1), { authorization: "crowdfund" }
}