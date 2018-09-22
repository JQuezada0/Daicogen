module Model exposing (..)

import CreateDaico.Model as CreateDaico
import Project.Model as TokenSale

type Msg
  = SetActivePage PageType
  | ChildMsg ChildMsg

type ChildMsg
  = CreateDaicoMsg CreateDaico.Msg
  | TokensaleMsg TokenSale.Msg

type PageType
  = LandingPage
  | CreateDaicoPage
  | DaicoPage

type Page
  = Landing
  | CreateDaico CreateDaico.Model
  | Daico TokenSale.Model

type alias Model =
  {
    activePage: Page
  }
