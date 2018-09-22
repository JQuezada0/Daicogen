import { Resolver, FieldResolver, Root } from "type-graphql"
import { VoteProposal } from "../db/entity/voteProposal"

@Resolver(VoteProposal)
export class VoteProposalResolver {
  @FieldResolver()
  idVoter(@Root() voteProposal: VoteProposal) {
    return voteProposal.idVoter
  }

  @FieldResolver()
  delegatedVoter(@Root() voteProposal: VoteProposal) {
    return voteProposal.delegatedVoter
  }

  @FieldResolver()
  choice(@Root() voteProposal: VoteProposal) {
    return voteProposal.choice
  }

  @FieldResolver()
  voteCompleted(@Root() voteProposal: VoteProposal) {
    return voteProposal.voteCompleted
  }

  @FieldResolver()
  poll(@Root() voteProposal: VoteProposal) {
    return voteProposal.poll
  }
}