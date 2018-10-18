module CreateCrowdfund.Model exposing (..)

import DatePicker
import Date

type Msg
  = CategorySelected (Maybe Category)
  | TitleUpdated (Maybe String)
  | DescriptionUpdated (Maybe String)
  | FundingGoalUpdated (Maybe Float)
  | CampaignDurationStartUpdated DatePicker.Msg
  | CampaignDurationEndUpdated DatePicker.Msg
  | RewardTitleUpdated (Maybe String)
  | RewardPledgeAmountUpdated (Maybe Float)
  | RewardDescriptionUpdated (Maybe String)
  | RewardDeliveryMonthUpdated (Maybe Date.Month)
  | RewardDeliveryYearUpdated (Maybe Int)
  | ChangeActiveStep ActiveStep
  | CompleteStepOne StepOne
  | CompleteStepTwo StepOne StepTwo
  | CompleteStepThree StepOne StepTwo StepThree
  | CompleteCampaign StepOne StepTwo StepThree StepFour

type alias Model =
  {
    activeStep: ActiveStep,
    categoryDetailsProgress: CategoryDetailsProgress,
    projectDetailsProgress: ProjectDetailsProgress,
    campaignDetailsProgress: CampaignDetailsProgress,
    rewardDetailsProgress: RewardDetailsProgress
  }

type StepOne
  = StepOneComplete CategoryDetails

type StepTwo
  = StepTwoComplete ProjectDetails

type StepThree
  = StepThreeComplete CampaignDetails

type StepFour
  = StepFourComplete RewardDetails

type ActiveStep
  = StepOne
  | StepTwo StepOne
  | StepThree StepOne StepTwo
  | StepFour StepOne StepTwo StepThree

type Category
  = Art
  | Comics
  | Crafts
  | Dance
  | Design
  | Fashion
  | FilmVideo
  | Food
  | Games
  | Journalism
  | Music
  | Photography
  | Publishing
  | Technology
  | Theatre

type alias Campaign = {
  categoryDetails: CategoryDetails,
  projectDetails: ProjectDetails,
  campaignDetails: CampaignDetails,
  rewardDetails: RewardDetails
}

type alias CategoryDetails = {
  category: Category
}

type alias ProjectDetails = {
  title: String,
  description: String,
  image: String
}

type alias CampaignDetails = {
  fundingGoal: Float,
  campaignStart: Date.Date,
  campaignEnd: Date.Date
}

type alias RewardDetails = {
  title: String,
  pledgeAmount: Float,
  description: String,
  estimatedDelivery: Float
}

type alias CategoryDetailsProgress = {
  category: Maybe Category
}

type alias ProjectDetailsProgress = {
  title: Maybe String,
  description: Maybe String,
  image: Maybe String
}

type alias CampaignDetailsProgress = {
  fundingGoal: Maybe Float,
  campaignStartDate: Maybe Date.Date,
  campaignEndDate: Maybe Date.Date,
  campaignDurationStartDatePicker: DatePicker.DatePicker,
  campaignDurationEndDatePicker: DatePicker.DatePicker
}

type alias RewardDetailsProgress = {
  title: Maybe String,
  pledgeAmount: Maybe Float,
  description: Maybe String,
  estimatedDeliveryMonth: Maybe Date.Month,
  estimatedDeliveryYear: Maybe Int
}

categoryFromString : String -> Maybe Category
categoryFromString str =
  case str of
    "Art" -> Just Art
    "Comics" -> Just Comics
    "Crafts" -> Just Crafts
    "Dance" -> Just Dance
    "Design" -> Just Design
    "Fashion" -> Just Fashion
    "FilmVideo" -> Just FilmVideo
    "Food" -> Just Food
    "Games" -> Just Games
    "Journalism" -> Just Journalism
    "Music" -> Just Music
    "Photography" -> Just Photography
    "Publishing" -> Just Publishing
    "Technology" -> Just Technology
    "Theatre" -> Just Theatre
    _ -> Nothing

monthFromString : String -> Maybe Date.Month
monthFromString str =
  case str of
    "Jan" -> Just Date.Jan
    "Feb" -> Just Date.Feb
    "Mar" -> Just Date.Mar
    "Apr" -> Just Date.Apr
    "May" -> Just Date.May
    "Jun" -> Just Date.Jun
    "Jul" -> Just Date.Jul
    "Aug" -> Just Date.Aug
    "Sep" -> Just Date.Sep
    "Oct" -> Just Date.Oct
    "Nov" -> Just Date.Nov
    "Dec" -> Just Date.Dec
    _ -> Nothing

startDatePickerSettings : DatePicker.Settings
startDatePickerSettings =
  let
    defaultSettings = DatePicker.defaultSettings
  in
    { defaultSettings |
      inputClassList = [ ("form-control", True), ("date-picker", True) ],
      inputId = Just ("step-three-startdate-datepicker"),
      classNamespace = "datepicker"
    }

endDatePickerSettings : DatePicker.Settings
endDatePickerSettings =
  let
    defaultSettings = DatePicker.defaultSettings
  in
    { defaultSettings |
      inputClassList = [ ("form-control", True), ("date-picker", True) ],
      inputId = Just ("step-three-enddate-datepicker"),
      classNamespace = "datepicker-"
    }