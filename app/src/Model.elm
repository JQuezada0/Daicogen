module Model exposing (..)

import CreateDaico.Model as CreateDaico

type Msg
  = SetActivePage Page
  | ChildMsg ChildMsg

type ChildMsg
  = CreateDaicoMsg CreateDaico.Msg

type Page
  = CreateDaico CreateDaico.Model

type alias Model =
  {
    activePage: Page
  }