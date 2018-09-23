module Project.Model exposing (..)

import Project.Api exposing (..)
import Graphqelm.Http exposing (..)

type Msg
  = SetActivePage Page
  | UpdateUserType String
  | RefreshVotes
  | UpdateSelectedVotingMethod (Maybe SelectedVotingMethod)
  | FetchProjectComplete (Result (Error Project) Project)
  | SubmitVote { icoaccount: String, idvoter: String, trvoter: String, currentVoter: String, pick: Bool }
  | SubmitSuggestion { icoaccount: String, from: String, to: String, pick: Bool }
  | RemoveSuggestion { from: String }
  | RemoveVote { icoaccount: String }
  | TransactionComplete

type Page
  = Voting

type UserType
  = IdAccount
  | GeneralAccount

type SelectedVotingMethod
  = IdAccountVote
  | DelegateVote

type alias Model = {
  activePage: Page,
  selectedUserType: Maybe UserType,
  selectedVotingMethod: Maybe SelectedVotingMethod,
  project: Maybe (Result (Error Project) Project)
}