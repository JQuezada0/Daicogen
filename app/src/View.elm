module View exposing (view)

import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import CreateDaico.View as CreateDaico

view : Model -> Html Msg
view model =
  case model.activePage of
    CreateDaico createDaicoModel ->
      CreateDaico.view createDaicoModel
        |> Html.map (CreateDaicoMsg >> ChildMsg)