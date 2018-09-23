module View exposing (view)

import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import DaicoTemplate.View as DaicoTemplate
import Project.View as Daico
import Spinner

view : Model -> Html Msg
view model =
  case model.activePage of
    Loading ->
      Spinner.view

    Landing ->
      viewLanding

    DaicoTemplate daicoTemplateModel ->
      DaicoTemplate.view daicoTemplateModel
        |> Html.map (DaicoTemplateMsg >> ChildMsg)

    Daico tokensaleModel ->
      Daico.view tokensaleModel
        |> Html.map (TokensaleMsg >> ChildMsg)

viewLanding : Html Msg
viewLanding =
  div [class "page-header", attribute "data-parallax" "true", style [("background-color", "#1c293a")]] [
    div [class "filter"] [],
    div [class "container"] [
      div [class "motto text-center"] [
        img [src "assets/img/daicogen-logo.png", width 750] [],
        h3 [] [
          text "Generate an honest, socially impactful token sale in minutes"
        ],
        br [] [],
        button [type_ "button", class "btn btn-outline-neutral btn-round", onClick (SetActivePage DaicoTemplatePage), style [("color", "white"), ("border-color", "white")]] [
          text "Get Started"
        ]
      ]
    ]
  ]