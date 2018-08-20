# Daicogen

Contains each part of the project

## App

The app directory contains the UI to interact with the webapp. This is where all UIs
for interacting with the Daicogen platform will live. 

https://app.daicogen.com

## Contract

The contract directory contains all contracts and supplemental classes/libraries.

### Getting Started

Run the following commands from within the contract directory.

Note: You will need [Docker](https://www.docker.com/) installed on your machine.

1. `docker-compose build` (Only for first time)
2. `docker-compose up`

After a few seconds the blockchain should be up and running in your container and be accessible via 
the browser at http://localhost:8888

Example: http://localhost:8888/v1/chain/get_info

Furthermore, the MongoDB plugin has been set up. Either using the command line or
a mongodb explorer UI such as [Robo3T](https://robomongo.org/), you can
access localhost:27017 and query for any data stored on the blockchain

## Public

The public directory contains the UI for the marketing site.

https://daicogen.com

## Server

The server directory will maintain an api that will exist between the UI
and the blockchain. This will make it easier for the UI to talk to an API
that is more familiar to web developers, and the server will handle
all logic around querying for and mutating data on the blockchain.
