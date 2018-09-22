module Project.Update exposing (init, update, subscriptions)

import Response exposing (..)
import Project.Model as Model exposing (..)

init : Response Model Msg
init =
  {
    activePage = TokenSale
  }
    |> withNone

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    SetActivePage page ->
      { model |
        activePage = page
      }
        |> withNone

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none