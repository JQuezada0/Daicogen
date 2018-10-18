module View exposing (view)

import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import CreateCrowdfund.View as CreateCrowdfund

view : Model -> Html Msg
view model =
  case model.activePage of
    CreateCrowdfundPage createCrowdfundModel ->
      CreateCrowdfund.view createCrowdfundModel
        |> Html.map (CreateCrowdfundMsg >> ChildMsg)