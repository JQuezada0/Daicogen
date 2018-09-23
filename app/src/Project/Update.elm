module Project.Update exposing (init, update, subscriptions)

import Response exposing (..)
import Project.Model as Model exposing (..)
import Project.Api as Api exposing (..)
import Ports

init : Response Model Msg
init =
  {
    activePage = Voting,
    selectedUserType = Nothing,
    selectedVotingMethod = Nothing,
    project = Nothing
  }
    |> withCmd (Api.getProject FetchProjectComplete)

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    SetActivePage page ->
      { model |
        activePage = page
      }
        |> withNone

    UpdateUserType userTypeString ->
      let
        userType =
          case userTypeString of
            "IdAccount" ->
              Just IdAccount
            "GeneralAccount" ->
              Just GeneralAccount
            _ ->
              Nothing
      in
        { model |
          selectedUserType = userType,
          selectedVotingMethod = Nothing
        }
          |> update RefreshVotes

    UpdateSelectedVotingMethod method ->
      {
        model |
        selectedVotingMethod = method
      }
        |> withNone

    RefreshVotes ->
      model
        |> withCmd (Api.getProject FetchProjectComplete)

    FetchProjectComplete res ->
      { model |
        project = Just res
      }
        |> withNone

    SubmitVote input ->
      model
        |> withCmd (Ports.vote input)

    SubmitSuggestion input ->
      model
        |> withCmd (Ports.createSuggestion input)

    RemoveSuggestion input ->
      model
        |> withCmd (Ports.removeSuggestion input)
        
    RemoveVote input ->
      model
        |> withNone

    TransactionComplete ->
      { model | selectedVotingMethod = Nothing }
        |> update RefreshVotes

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [
    Ports.transactionComplete (always TransactionComplete)
  ]