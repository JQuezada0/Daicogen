module Update exposing (..)

import Response exposing (..)
import Model exposing (..)
import DaicoTemplate.Update as DaicoTemplate
import Project.Update as TokenSale
import Api

init : Response Model Msg
init = 
  {
    activePage = Loading
  }
    |> withCmd (Api.projectsExist ExistingProjects)

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    SetActivePage LandingPage ->
      { model |
        activePage = Landing
      }
        |> Response.withNone

    SetActivePage DaicoTemplatePage ->
      let
        (daicoTemplateModel, daicoTemplateCmd) = DaicoTemplate.init
      in
        {
          activePage = DaicoTemplate daicoTemplateModel
        }
          |> withCmd (Cmd.map (DaicoTemplateMsg >> ChildMsg) daicoTemplateCmd)

    SetActivePage DaicoPage ->
      let
        (tokenSaleModel, tokenSaleCmd) = TokenSale.init
      in
        {
          activePage = Daico tokenSaleModel
        }
          |> withCmd (Cmd.map (TokensaleMsg >> ChildMsg) tokenSaleCmd)

    ChildMsg (DaicoTemplateMsg msg) -> 
      case model.activePage of
        DaicoTemplate daicoTemplateModel ->
          daicoTemplateModel
            |> DaicoTemplate.update msg
            |> Response.mapModel (\daicoTemplateModel -> { model | activePage = DaicoTemplate daicoTemplateModel })
            |> Response.mapCmd (DaicoTemplateMsg >> ChildMsg)
        _ ->
          model
            |> withNone

    ChildMsg (TokensaleMsg msg) -> 
      case model.activePage of
        Daico tokensaleModel ->
          tokensaleModel
            |> TokenSale.update msg
            |> Response.mapModel (\tokensaleModel -> { model | activePage = Daico tokensaleModel })
            |> Response.mapCmd (TokensaleMsg >> ChildMsg)
        _ ->
          model
            |> withNone

    ExistingProjects res ->
      let
        projectsCount = 
          res
            |> Result.withDefault 0
      in
        if projectsCount < 1 then
          model
            |> update (SetActivePage LandingPage)
        else
          model
            |> update (SetActivePage DaicoPage)

subscriptions : Model -> Sub Msg
subscriptions model =
  case model.activePage of
    DaicoTemplate daicoTemplateModel ->
      DaicoTemplate.subscriptions daicoTemplateModel
        |> Sub.map (DaicoTemplateMsg >> ChildMsg)
    Daico daicoModel ->
      TokenSale.subscriptions daicoModel
        |> Sub.map (TokensaleMsg >> ChildMsg)
    _ ->
      Sub.none