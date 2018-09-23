import * as Crowdsale from "../contracts/crowdsale"
import * as Voting from "../contracts/voting"

export namespace Main {
  export interface App {
    ports: {
      createVoting: {
        subscribe(callback: (data: Voting.CreateVotingInput) => void): void
      },
      removeVoting: {
        subscribe(callback: (data: Voting.RemoveVotingInput) => void): void
      },
      vote: {
        subscribe(callback: (data: Voting.VoteInput) => void): void
      },
      removeVote: {
        subscribe(callback: (data: Voting.RemoveVoteInput) => void): void
      },
      createSuggestion: {
        subscribe(callback: (data: Voting.CreateSuggestionInput) => void): void
      },
      removeSuggestion: {
        subscribe(callback: (data: Voting.RemoveSuggestionInput) => void): void
      },
      submitTemplate: {
        subscribe(callback: (data: any) => void): void
      },
      transactionComplete: {
        send(): void
      }
    };
  }

  export function fullscreen(): Main.App;
  export function embed(node: HTMLElement | null): Main.App;
}