import * as express from 'express'
import actionReader from "./actionReader/index"
import { ApolloServer } from 'apollo-server-express'
import { buildSchema } from 'type-graphql'
import { CampaignResolver } from "./schema/campaign"

const init = async () => {
  await actionReader()
  const schema = await buildSchema({ resolvers: [ CampaignResolver ] })
  const server = new ApolloServer({ schema })
  const app = express()

  server.applyMiddleware({ app })

  app.listen({ port: 5555, hostname: '0.0.0.0' }, async () => {
    console.log(`🚀 Server ready at http://0.0.0.0:5555${server.graphqlPath}`)
  })
}

init()