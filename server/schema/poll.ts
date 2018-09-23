import { Resolver, FieldResolver, Root } from "type-graphql"
import { Poll } from "../db/entity/poll"
import { Vote } from "../db/entity/vote"
import { VoteProposal } from "../db/entity/voteProposal"

@Resolver(Poll)
export class PollResolver {
  @FieldResolver()
  icocreator(@Root() poll: Poll): string {
    return poll.icocreator
  }

  @FieldResolver()
  proposal(@Root() poll: Poll): string {
    return poll.proposal
  }

  @FieldResolver()
  yesvotes(@Root() poll: Poll): number {
    return poll.yesvotes
  }

  @FieldResolver()
  novotes(@Root() poll: Poll): number {
    return poll.novotes
  }

  @FieldResolver(type => [Vote])
  votes(@Root() poll: Poll): Vote[] {
    return poll.votes
  }

  @FieldResolver(type => [VoteProposal])
  voteProposals(@Root() poll: Poll): VoteProposal[] {
    return poll.voteProposals
  }
}