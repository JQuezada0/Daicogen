module Main exposing (..)

import Html exposing (..)
import Update
import View


main =
  Html.program
    { init = Update.init
    , view = View.view
    , update = Update.update
    , subscriptions = Update.subscriptions
    }