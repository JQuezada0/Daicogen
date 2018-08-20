# Daicogen

Contains each part of the project

## Requirements

1. Docker
2. NPM
3. Yarn

## App

The app directory contains the UI to interact with the webapp. This is where all UIs
for interacting with the Daicogen platform will live. 

https://app.daicogen.com

## Contract

The contract directory contains all contracts and supplemental classes/libraries.

## Public

The public directory contains the UI for the marketing site.

https://daicogen.com

## Server

The server directory will maintain an api that will exist between the UI
and the blockchain. This will make it easier for the UI to talk to an API
that is more familiar to web developers, and the server will handle
all logic around querying for and mutating data on the blockchain.

### Getting Started

1. `docker-compose build` (Only for first time)
2. `docker-compose up`

After a few seconds the blockchain should be up and running in a container and be accessible via 
the browser at http://localhost:8888

Example: http://localhost:8888/v1/chain/get_info

The MongoDB plugin has been set up. Either using the command line or
a mongodb explorer UI such as [Robo3T](https://robomongo.org/), you can
access localhost:27017 and query for any data stored on the blockchain

A GraphQL Server is exposed at http://localhost:5555 when making a `POST` request,
and an interactive query UI is shown in the browser when making a `GET` request
