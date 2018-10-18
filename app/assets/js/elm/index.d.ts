import * as Crowdfund from "../contracts/crowdfund"

export namespace Main {
  export interface App {
    ports: {
      submitCampaign: {
        subscribe(callback: (data: Crowdfund.CreateCampaignInput) => void): void
      }
    };
  }

  export function fullscreen(): Main.App;
  export function embed(node: HTMLElement | null): Main.App;
}