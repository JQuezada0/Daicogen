module Model exposing (..)

import CreateCrowdfund.Model as CreateCrowdfund

type Msg
  = SetActivePage PageType
  | ChildMsg ChildMsg

type ChildMsg
  = CreateCrowdfundMsg CreateCrowdfund.Msg

type PageType
  = CreateCrowdfund

type Page
  = CreateCrowdfundPage CreateCrowdfund.Model

type alias Model =
  {
    activePage: Page
  }
