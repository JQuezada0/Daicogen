import { Campaign } from "../db/entity/campaign"
import { Resolver, Query, FieldResolver, Root, Arg } from "type-graphql"

@Resolver(Campaign)
export class CampaignResolver {
  @Query(() => [Campaign])
  async campaigns() {
    return Campaign.find()
  }

  @Query(() => Campaign)
  async campaign(@Arg("id") id: number) {
    return await Campaign.findOne(id)
  }

  @FieldResolver()
  id(@Root() campaign: Campaign) {
    return campaign.id
  }

  @FieldResolver()
  creator(@Root() campaign: Campaign) {
    return campaign.creator
  }

  @FieldResolver()
  category(@Root() campaign: Campaign) {
    return campaign.category
  }

  @FieldResolver()
  projectTitle(@Root() campaign: Campaign): string {
    return campaign.project_title
  }

  @FieldResolver()
  description(@Root() campaign: Campaign) {
    return campaign.description
  }

  @FieldResolver()
  image(@Root() campaign: Campaign) {
    return campaign.image
  }

  @FieldResolver()
  fundingGoal(@Root() campaign: Campaign): number {
    return campaign.funding_goal
  }

  @FieldResolver()
  campaignStart(@Root() campaign: Campaign): number {
    return campaign.campaign_start
  }

  @FieldResolver()
  campaignEnd(@Root() campaign: Campaign): number {
    return campaign.campaign_end
  }

  @FieldResolver()
  title(@Root() campaign: Campaign) {
    return campaign.title
  }

  @FieldResolver()
  pledgeAmount(@Root() campaign: Campaign): number {
    return campaign.pledge_amount
  }

  @FieldResolver()
  rewardDescription(@Root() campaign: Campaign): string {
    return campaign.reward_description
  }

  @FieldResolver()
  estimatedDelivery(@Root() campaign: Campaign): number {
    return campaign.estimated_delivery
  }
}