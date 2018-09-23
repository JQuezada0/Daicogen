module Model exposing (..)

import DaicoTemplate.Model as DaicoTemplate
import Project.Model as TokenSale
import Graphqelm.Http exposing (..)

type Msg
  = SetActivePage PageType
  | ChildMsg ChildMsg
  | ExistingProjects (Result (Error Int) Int)

type ChildMsg
  = DaicoTemplateMsg DaicoTemplate.Msg
  | TokensaleMsg TokenSale.Msg

type PageType
  = LandingPage
  | DaicoTemplatePage
  | DaicoPage

type Page
  = Loading
  | Landing
  | DaicoTemplate DaicoTemplate.Model
  | Daico TokenSale.Model

type alias Model =
  {
    activePage: Page
  }
