module Api exposing (..)

import Api.Query as Query
import Graphqelm.SelectionSet as SelectionSet exposing (..)
import Graphqelm.Field exposing (..)
import Graphqelm.Http exposing (..)
import Api.Object.Project as GQLProject

projectsExist : (Result (Error Int) Int -> msg) -> Cmd msg
projectsExist toMsg =
  Query.selection identity
    |> with (Query.projects SelectionSet.empty)
    |> SelectionSet.map List.length
    |> queryRequest "http://localhost:5555/graphql"
    |> send toMsg