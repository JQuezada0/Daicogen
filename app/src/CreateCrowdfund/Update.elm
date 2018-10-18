module CreateCrowdfund.Update exposing (init, update, subscriptions)

import Response exposing (..)
import CreateCrowdfund.Model as Model exposing (..)
import Ports
import DatePicker

init : Response Model Msg
init =
  let
    (startDatePicker, startDatePickerCmd) = DatePicker.init
    (endDatePicker, endDatePickerCmd) = DatePicker.init
    startDateCmd = Cmd.map CampaignDurationStartUpdated startDatePickerCmd
    endDateCmd = Cmd.map CampaignDurationEndUpdated endDatePickerCmd
  in
    {
      activeStep = StepOne,
      categoryDetailsProgress = CategoryDetailsProgress Nothing,
      projectDetailsProgress = ProjectDetailsProgress Nothing Nothing (Just ""),
      campaignDetailsProgress = CampaignDetailsProgress Nothing Nothing Nothing startDatePicker endDatePicker,
      rewardDetailsProgress = RewardDetailsProgress Nothing Nothing Nothing Nothing Nothing
    }
      |> withCmd (Cmd.batch [startDateCmd, endDateCmd])

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    CategorySelected category ->
      model
        |> updateCategoryDetailsProgress (\c -> { c | category = category })
        |> withNone

    TitleUpdated title ->
      model
        |> updateProjectDetailsProgress (\p -> { p | title = title })
        |> withNone

    DescriptionUpdated description ->
      model
        |> updateProjectDetailsProgress (\p -> { p | description = description })
        |> withNone

    FundingGoalUpdated fundingGoal ->
      model
        |> updateCampaignDetailsProgress (\c -> { c | fundingGoal = fundingGoal })
        |> withNone

    CampaignDurationStartUpdated msg ->
      let
        (datePicker, datePickerCmd, dateEvent) =
          DatePicker.update startDatePickerSettings msg model.campaignDetailsProgress.campaignDurationStartDatePicker
        startDateCmd = Cmd.map CampaignDurationStartUpdated datePickerCmd
        updatedDate =
          case dateEvent of
            DatePicker.NoChange ->
              model.campaignDetailsProgress.campaignStartDate
            DatePicker.Changed Nothing ->
              model.campaignDetailsProgress.campaignStartDate
            DatePicker.Changed (Just date) ->
              Just date
      in
        model
          |> updateCampaignDetailsProgress (\c -> { c | campaignDurationStartDatePicker = datePicker, campaignStartDate = updatedDate })
          |> withCmd startDateCmd

    CampaignDurationEndUpdated msg ->
      let
        (datePicker, datePickerCmd, dateEvent) =
          DatePicker.update endDatePickerSettings msg model.campaignDetailsProgress.campaignDurationEndDatePicker
        endDateCmd = Cmd.map CampaignDurationEndUpdated datePickerCmd
        updatedDate =
          case dateEvent of
            DatePicker.NoChange ->
              model.campaignDetailsProgress.campaignEndDate
            DatePicker.Changed Nothing ->
              model.campaignDetailsProgress.campaignEndDate
            DatePicker.Changed (Just date) ->
              Just date
      in
        model
          |> updateCampaignDetailsProgress (\c -> { c | campaignDurationEndDatePicker = datePicker, campaignEndDate = updatedDate })
          |> withCmd endDateCmd

    RewardTitleUpdated title ->
      model
        |> updateRewardDetailsProgress (\r -> { r | title = title })
        |> withNone
    
    RewardPledgeAmountUpdated pledgeAmount ->
      model
        |> updateRewardDetailsProgress (\r -> { r | pledgeAmount = pledgeAmount })
        |> withNone

    RewardDescriptionUpdated description ->
      model
        |> updateRewardDetailsProgress (\r -> { r | description = description })
        |> withNone

    RewardDeliveryMonthUpdated estimatedDeliveryMonth ->
      model
        |> updateRewardDetailsProgress (\r -> { r | estimatedDeliveryMonth = estimatedDeliveryMonth })
        |> withNone

    RewardDeliveryYearUpdated estimatedDeliveryYear ->
      model
        |> updateRewardDetailsProgress (\r -> { r | estimatedDeliveryYear = estimatedDeliveryYear })
        |> withNone

    ChangeActiveStep activeStep ->
      { model | activeStep = activeStep }
        |> withNone

    CompleteStepOne stepOne ->
      { model |
        activeStep = StepTwo stepOne
      }
        |> withNone

    CompleteStepTwo stepOne stepTwo ->
      { model |
        activeStep = StepThree stepOne stepTwo
      }
        |> withNone

    CompleteStepThree stepOne stepTwo stepThree ->
      { model |
        activeStep = StepFour stepOne stepTwo stepThree
      }
        |> withNone

    CompleteCampaign stepOne stepTwo stepThree stepFour ->
      let
        (StepOneComplete categoryDetails) = stepOne
        (StepTwoComplete projectDetails) = stepTwo
        (StepThreeComplete campaignDetails) = stepThree
        (StepFourComplete rewardDetails) = stepFour
        campaign = Campaign categoryDetails projectDetails campaignDetails rewardDetails
        formattedCampaign = Ports.formatCampaign campaign
      in
        model
          |> withCmd (Ports.submitCampaign formattedCampaign)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

updateCategoryDetailsProgress : (CategoryDetailsProgress -> CategoryDetailsProgress) -> Model -> Model
updateCategoryDetailsProgress updater model =
  let
    updatedCategoryDetailsProgress = updater model.categoryDetailsProgress
  in
    { model | categoryDetailsProgress = updatedCategoryDetailsProgress }

updateProjectDetailsProgress : (ProjectDetailsProgress -> ProjectDetailsProgress) -> Model -> Model
updateProjectDetailsProgress updater model =
  let
    updatedProjectDetailsProgress = updater model.projectDetailsProgress
  in
    { model | projectDetailsProgress = updatedProjectDetailsProgress }

updateCampaignDetailsProgress : (CampaignDetailsProgress -> CampaignDetailsProgress) -> Model -> Model
updateCampaignDetailsProgress updater model =
  let
    updatedCampaignDetailsProgress = updater model.campaignDetailsProgress
  in
    { model | campaignDetailsProgress = updatedCampaignDetailsProgress }

updateRewardDetailsProgress : (RewardDetailsProgress -> RewardDetailsProgress) -> Model -> Model
updateRewardDetailsProgress updater model =
  let
    updatedRewardDetailsProgress = updater model.rewardDetailsProgress
  in
    { model | rewardDetailsProgress = updatedRewardDetailsProgress }