import { Resolver, FieldResolver, Root } from "type-graphql"
import { VoteProposal } from "../db/entity/voteProposal"

@Resolver(VoteProposal)
export class VoteProposalResolver {
  @FieldResolver()
  iconame(@Root() voteProposal: VoteProposal) {
    return voteProposal.iconame
  }

  @FieldResolver()
  from(@Root() voteProposal: VoteProposal) {
    return voteProposal.from
  }

  @FieldResolver()
  to(@Root() voteProposal: VoteProposal) {
    return voteProposal.to
  }

  @FieldResolver()
  pick(@Root() voteProposal: VoteProposal) {
    return voteProposal.pick
  }
}