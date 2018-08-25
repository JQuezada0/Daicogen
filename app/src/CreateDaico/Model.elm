module CreateDaico.Model exposing (..)

type Msg
  = UpdateFormSection FormSection

type FormSection
  = Description
  | Tokensale
  | Funding
  | Voting
  | Charity

type alias Model =
  {
    activeFormSection : FormSection
  }