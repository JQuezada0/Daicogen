import * as express from 'express'
import { ApolloServer, gql } from 'apollo-server-express'
import { importSchema } from 'graphql-import'

const resolvers = {}

const server = new ApolloServer({
  typeDefs: gql(importSchema(`${__dirname}/schema.graphql`)),
  resolvers
})

const app = express()

server.applyMiddleware({ app })

app.listen({ port: 5555, hostname: '0.0.0.0' }, () =>
  console.log(`🚀 Server ready at http://0.0.0.0:5555${server.graphqlPath}`)
)
