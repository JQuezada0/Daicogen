module Main exposing (..)

main : Program Never Model Msg
main =
  Html.program
    { init = Update.init
    , view = View.view
    , update = Update.update
    , subscriptions = Update.subscriptions
    }
