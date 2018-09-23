module Project.Api exposing (..)

import Api.Query as Query
import Graphqelm.SelectionSet exposing (..)
import Graphqelm.Field exposing (..)
import Graphqelm.Http exposing (..)
import Api.Object.Project as GQLProject
import Api.Object.Poll as GQLPoll
import Api.Object.Vote as GQLVote
import Api.Object.VoteProposal as GQLVoteProposal

type alias Project = {
  owner: String,
  name: String,
  description: String,
  url: String,
  polls: List Poll
}

type alias Poll = {
  icocreator: String,
  proposal: String,
  yesVotes: Float,
  noVotes: Float,
  votes: List Vote,
  voteProposals: List VoteProposal
}

type alias Vote = {
  iconame: String,
  idvoter: String,
  trvoter: String,
  pick: Bool
}

type alias VoteProposal = {
  iconame: String,
  from: String,
  to: String,
  pick: Bool
}

getProject : ((Result (Error Project) Project) -> msg) -> Cmd msg
getProject toMsg =
  Query.selection identity 
    |> with (Query.project { accountName = "crowdsale" } (
        GQLProject.selection Project
          |> with GQLProject.owner
          |> with GQLProject.name
          |> with GQLProject.description
          |> with GQLProject.url
          |> with (GQLProject.polls (
              GQLPoll.selection Poll
                |> with GQLPoll.icocreator
                |> with GQLPoll.proposal
                |> with GQLPoll.yesvotes
                |> with GQLPoll.novotes
                |> with (GQLPoll.votes (
                    GQLVote.selection Vote
                      |> with GQLVote.iconame
                      |> with GQLVote.idvoter
                      |> with GQLVote.trvoter
                      |> with GQLVote.pick
                ))
                |> with (GQLPoll.voteProposals (
                    GQLVoteProposal.selection VoteProposal
                      |> with GQLVoteProposal.iconame
                      |> with GQLVoteProposal.from
                      |> with GQLVoteProposal.to
                      |> with GQLVoteProposal.pick
                ))
          ))
    ))
    |> queryRequest "http://localhost:5555/graphql"
    |> send toMsg