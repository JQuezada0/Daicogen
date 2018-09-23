import { Resolver, FieldResolver, Root } from "type-graphql"
import { Vote } from "../db/entity/vote"

@Resolver(Vote)
export class VoteResolver {
  @FieldResolver()
  iconame(@Root() vote: Vote) {
    return vote.iconame
  }

  @FieldResolver()
  idvoter(@Root() vote: Vote) {
    return vote.idvoter
  }

  @FieldResolver()
  trvoter(@Root() vote: Vote) {
    return vote.trvoter
  }

  @FieldResolver()
  pick(@Root() vote: Vote) {
    return vote.pick
  }
}