import { Resolver, FieldResolver, Root } from "type-graphql"
import { Poll } from "../db/entity/poll"

@Resolver(Poll)
export class PollResolver {
  @FieldResolver()
  kind(@Root() poll: Poll) {
    return poll.kind
  }

  @FieldResolver()
  symbol(@Root() poll: Poll) {
    return poll.pollPassed
  }

  @FieldResolver()
  supply(@Root() poll: Poll) {
    return poll.pollFinalized
  }

  @FieldResolver()
  project(@Root() poll: Poll) {
    return poll.project
  }

  @FieldResolver()
  votes(@Root() poll: Poll) {
    return poll.votes
  }
}