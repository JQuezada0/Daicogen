module Project.Model exposing (..)

type Msg
  = SetActivePage Page

type Page
  = Voting

type alias Model = {
  activePage: Page
}