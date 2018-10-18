module Update exposing (..)

import Response exposing (..)
import Model exposing (..)
import CreateCrowdfund.Update as CreateCrowdfund

init : Response Model Msg
init = 
  let
    (createCrowdfundModel, createCrowdfundCmd) = CreateCrowdfund.init
  in
    {
      activePage = CreateCrowdfundPage createCrowdfundModel
    }
      |> withCmd (Cmd.map (CreateCrowdfundMsg >> ChildMsg) createCrowdfundCmd)

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    SetActivePage CreateCrowdfund ->
      let
        (createCrowdfundModel, createCrowdfundCmd) = CreateCrowdfund.init
      in
        {
          activePage = CreateCrowdfundPage createCrowdfundModel
        }
          |> withCmd (Cmd.map (CreateCrowdfundMsg >> ChildMsg) createCrowdfundCmd)

    ChildMsg (CreateCrowdfundMsg createCrowdfundMsg) ->
      case model.activePage of
        CreateCrowdfundPage createCrowdfundModel ->
          CreateCrowdfund.update createCrowdfundMsg createCrowdfundModel
            |> mapModel (\createCrowdfundModel -> { model | activePage = CreateCrowdfundPage createCrowdfundModel })
            |> mapCmd (CreateCrowdfundMsg >> ChildMsg)

subscriptions : Model -> Sub Msg
subscriptions model =
  case model.activePage of
    CreateCrowdfundPage createCrowdfundModel ->
      CreateCrowdfund.subscriptions createCrowdfundModel
        |> Sub.map (CreateCrowdfundMsg >> ChildMsg)