import * as express from 'express'
import actionReader from "./actionReader/index"
import { ApolloServer, gql } from 'apollo-server-express'
import { buildSchema } from 'type-graphql'
import { PollResolver } from "./schema/poll"
import { ProjectResolver } from "./schema/project"
import { TokenSaleResolver } from "./schema/tokenSale"
import { VoteResolver } from "./schema/vote"
import { VoteProposalResolver } from "./schema/voteProposal"

const init = async () => {
  const schema = await buildSchema({ resolvers: [ PollResolver, ProjectResolver, TokenSaleResolver, VoteResolver, VoteProposalResolver ] })
  const server = new ApolloServer({ schema })
  const app = express()

  server.applyMiddleware({ app })

  await actionReader()

  app.listen({ port: 5555, hostname: '0.0.0.0' }, async () => {
    console.log(`🚀 Server ready at http://0.0.0.0:5555${server.graphqlPath}`)
  })
}

init()