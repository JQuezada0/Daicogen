port module Ports exposing (..)

import CreateCrowdfund.Model as CreateCrowdfund
import Date

formatCampaign : CreateCrowdfund.Campaign -> FormattedCampaign
formatCampaign campaign = 
  {
    categoryDetails = {
      category = toString campaign.categoryDetails.category
    },
    projectDetails = campaign.projectDetails,
    campaignDetails = {
      fundingGoal = campaign.campaignDetails.fundingGoal,
      campaignStart = Date.toTime campaign.campaignDetails.campaignStart,
      campaignEnd = Date.toTime campaign.campaignDetails.campaignEnd
    },
    rewardDetails = campaign.rewardDetails
  }

type alias FormattedCampaign =
  {
    categoryDetails: { category: String },
    projectDetails: CreateCrowdfund.ProjectDetails,
    campaignDetails: {
      fundingGoal: Float,
      campaignStart: Float,
      campaignEnd: Float
    },
    rewardDetails: CreateCrowdfund.RewardDetails
  }

port submitCampaign : FormattedCampaign -> Cmd msg
