import { Resolver, FieldResolver, Root } from "type-graphql"
import { Vote } from "../db/entity/vote"

@Resolver(Vote)
export class VoteResolver {
  @FieldResolver()
  voter(@Root() vote: Vote) {
    return vote.voter
  }

  @FieldResolver()
  confirmed(@Root() vote: Vote) {
    return vote.confirmed
  }

  @FieldResolver()
  poll(@Root() vote: Vote) {
    return vote.poll
  }
}