module CreateDaico.Update exposing (init, update, subscriptions)

import Response exposing (..)
import CreateDaico.Model as Model exposing (..)

init : Response Model Msg
init =
  {
    activeFormSection = Description
  }
    |> withNone

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    UpdateFormSection formSection ->
      { model |
        activeFormSection = formSection
      }
        |> withNone

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none