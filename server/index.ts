import * as express from 'express'
import { ApolloServer, gql } from 'apollo-server-express'
import { buildSchema } from 'type-graphql'

const init = async () => {
  const schema = await buildSchema({ resolvers: [] })
  const server = new ApolloServer({ schema })
  const app = express()

  server.applyMiddleware({ app })

  app.listen({ port: 5555, hostname: '0.0.0.0' }, async () => {
    console.log(`🚀 Server ready at http://0.0.0.0:5555${server.graphqlPath}`)
  })
}

init()