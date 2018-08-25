module Update exposing (..)

import Response exposing (..)
import Model exposing (..)
import CreateDaico.Update as CreateDaico

init : Response Model Msg
init = 
  let
    (createDaicoModel, createDaicoCmd) = CreateDaico.init
  in
    {
      activePage = CreateDaico createDaicoModel
    }
      |> withCmd (Cmd.map (CreateDaicoMsg >> ChildMsg) createDaicoCmd)

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    SetActivePage page ->
      { model |
        activePage = page
      }
        |> Response.withNone

    ChildMsg (CreateDaicoMsg msg) -> 
      case model.activePage of
        CreateDaico createDaicoModel ->
          createDaicoModel
            |> CreateDaico.update msg
            |> Response.mapModel (\createDaicoModel -> { model | activePage = CreateDaico createDaicoModel })
            |> Response.mapCmd (CreateDaicoMsg >> ChildMsg)

subscriptions : Model -> Sub Msg
subscriptions model =
  case model.activePage of
    CreateDaico createDaicoModel ->
      CreateDaico.subscriptions createDaicoModel
        |> Sub.map (CreateDaicoMsg >> ChildMsg)