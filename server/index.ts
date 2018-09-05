import * as express from 'express'
import { ApolloServer, gql } from 'apollo-server-express'
import { importSchema } from 'graphql-import'
import actionReader from "./actionReader/index"

const resolvers = {}

const setup = async () => await actionReader

const server = new ApolloServer({
  typeDefs: gql(importSchema(`${__dirname}/schema.graphql`)),
  resolvers
})

const app = express()

server.applyMiddleware({ app })

app.listen({ port: 5555, hostname: '0.0.0.0' }, async () => {
  await setup()
  console.log(`🚀 Server ready at http://0.0.0.0:5555${server.graphqlPath}`)
})
