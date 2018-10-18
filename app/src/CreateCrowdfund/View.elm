module CreateCrowdfund.View exposing (view)

import CreateCrowdfund.Model as Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.Button as Button
import Bootstrap.Text as Text
import Bootstrap.Form as Form
import Bootstrap.Form.Textarea as Textarea
import Bootstrap.Form.Select as Select
import Bootstrap.Form.Input as Input
import Date
import Bootstrap.Utilities.Spacing as Spacing
import Maybe.Extra as Maybe
import String.Extra as String
import Lib.Number as Number
import DatePicker
import Date.Extra.Field as DateField

view : Model -> Html Msg
view model = 
  Grid.container [] [
    Grid.row [] [
      Grid.col [Col.xs12, Col.textAlign Text.alignXsCenter] [
        h1 [class "mb-0"] [
          text "COINSTARTER"
        ]
      ]
    ],
    Grid.row [] [
      Grid.col [Col.xs12] [
        hr [] []
      ]
    ],
    Grid.row [] [
      Grid.col [Col.xsAuto] [
        text "1 of 3"
      ]
    ],
    case model.activeStep of
      StepOne ->
        viewStepOne model.categoryDetailsProgress
      StepTwo stepOne ->
        viewStepTwo stepOne model.projectDetailsProgress
      StepThree stepOne stepTwo ->
        viewStepThree stepOne stepTwo model.campaignDetailsProgress
      StepFour stepOne stepTwo stepThree ->
        viewStepFour stepOne stepTwo stepThree model.rewardDetailsProgress
  ]

viewStepOne : CategoryDetailsProgress -> Html Msg
viewStepOne { category } =
  Grid.row [Row.centerXs, Row.attrs [Spacing.pt5, Spacing.pb5]] [
    Grid.col [Col.xs6, Col.textAlign Text.alignXsCenter, Col.middleXs] [
      h2 [Spacing.mb0] [
        text "First, let's get you set up."
      ],
      h4 [class "text-muted", Spacing.mt1] [
        text "Pick a project category to connect with a specific community. You can always update this later."
      ],
      Select.select [
        Select.id "step-one-category-select",
        Select.onChange (categoryFromString >> CategorySelected),
        Select.large
      ] [
        Select.item [] [ text "Select your category" ],
        Select.item [ value (toString Art) ] [text "Art"],
        Select.item [ value (toString Comics) ] [text "Comics"],
        Select.item [ value (toString Crafts) ] [text "Crafts"],
        Select.item [ value (toString Dance) ] [text "Dance"],
        Select.item [ value (toString Design) ] [text "Design"],
        Select.item [ value (toString Fashion) ] [text "Fashion"],
        Select.item [ value (toString FilmVideo) ] [text "Film & Video"],
        Select.item [ value (toString Food) ] [text "Food"],
        Select.item [ value (toString Games) ] [text "Games"],
        Select.item [ value (toString Journalism) ] [text "Journalism"],
        Select.item [ value (toString Music) ] [text "Music"],
        Select.item [ value (toString Photography) ] [text "Photography"],
        Select.item [ value (toString Publishing) ] [text "Publishing"],
        Select.item [ value (toString Technology) ] [text "Technology"],
        Select.item [ value (toString Theatre) ] [text "Theatre"]
      ],
      hr [Spacing.mt5] [],
      Grid.row [Row.rightXs] [
        Grid.col [Col.xsAuto] [
          let
            buttonText = "Next: Project idea"
            buttonType = Button.primary
            completeStepOne category = StepOneComplete (CategoryDetails category)
          in
            case category of
              Nothing ->
                Button.button [buttonType, Button.disabled True] [
                  text buttonText
                ]
              Just category ->
                Button.button [buttonType, Button.onClick (CompleteStepOne (completeStepOne category))] [
                  text buttonText
                ]
        ]
      ]
    ]
  ]

viewStepTwo : StepOne -> ProjectDetailsProgress -> Html Msg
viewStepTwo stepOne { title, description, image } =
  Grid.row [Row.centerXs, Row.attrs [Spacing.pt5, Spacing.pb5]] [
    Grid.col [Col.xs6, Col.middleXs] [
      h2 [Spacing.mb0, class "text-center"] [
        text "Describe what you’ll be creating."
      ],
      h4 [class "text-muted text-center", Spacing.mt1] [
        text "And don’t worry, you can edit this later, too."
      ],
      Form.group [] [
        Form.label [for "step-two-title-input"] [
          text "Title"
        ],
        Input.text [
          Input.id "step-two-title-input",
          Input.placeholder "MaKey MaKey: An Invention Kit For Everyone",
          Input.onInput (String.nonEmpty >> TitleUpdated)
        ]
      ],
      Form.group [] [
        Form.label [for "step-two-description-textarea"] [
          text "Description"
        ],
        Textarea.textarea [
          Textarea.id "step-two-description-textarea",
          Textarea.rows 3,
          Textarea.onInput (String.nonEmpty >> DescriptionUpdated),
          Textarea.attrs [placeholder "A documentary about the history of shoes.", class "p-2"]
        ]
      ],
      hr [Spacing.mt5] [],
      Grid.row [Row.betweenXs] [
        Grid.col [Col.xsAuto] [
          Button.button [Button.onClick (ChangeActiveStep StepOne), Button.attrs [class "btn-neutral"]] [
            text "<- Category"
          ]
        ],
        Grid.col [Col.xsAuto] [
          let
            buttonText = "Next: Campaign"
            buttonType = Button.primary
            projectDetails = Maybe.map3 (ProjectDetails) title description image
            completeStepTwo projectDetails = CompleteStepTwo stepOne (StepTwoComplete projectDetails)
          in
            case projectDetails of
              Nothing ->
                Button.button [buttonType, Button.disabled True] [
                  text buttonText
                ]
              Just projectDetails ->
                Button.button [buttonType, Button.onClick (completeStepTwo projectDetails)] [
                  text buttonText
                ]
        ]
      ]
    ]
  ]

viewStepThree : StepOne -> StepTwo -> CampaignDetailsProgress -> Html Msg
viewStepThree stepOne stepTwo progress =
  let
    { fundingGoal, campaignStartDate, campaignEndDate, campaignDurationStartDatePicker, campaignDurationEndDatePicker } = progress
  in
    Grid.row [Row.centerXs, Row.attrs [Spacing.pt5, Spacing.pb5]] [
    Grid.col [Col.xs6, Col.middleXs] [
      h2 [Spacing.mb0, class "text-center"] [
        text "Design your campaign."
      ],
      h4 [class "text-muted text-center", Spacing.mt1] [
        text "And don’t worry, you can edit this later, too."
      ],
      Form.group [] [
        Form.label [for "step-three-funding-input"] [
          text "Funding Goal"
        ],
        Input.number [
          Input.id "step-three-funding-input",
          Input.placeholder "0",
          Input.onInput (String.toFloat >> Result.toMaybe >> Maybe.andThen Number.nonZeroFloat >> FundingGoalUpdated)
        ]
      ],
      Form.group [] [
        Form.label [for "step-three-startdate-datepicker"] [
          text "Start Date"
        ],
        DatePicker.view
          campaignStartDate
          startDatePickerSettings
          campaignDurationStartDatePicker
        |> Html.map CampaignDurationStartUpdated
      ],
      Form.group [] [
        Form.label [for "step-three-enddate-datepicker"] [
          text "End Date"
        ],
        DatePicker.view
          campaignEndDate
          endDatePickerSettings
          campaignDurationEndDatePicker
        |> Html.map CampaignDurationEndUpdated
      ],
      hr [Spacing.mt5] [],
      Grid.row [Row.betweenXs] [
        Grid.col [Col.xsAuto] [
          Button.button [Button.onClick (ChangeActiveStep StepOne), Button.attrs [class "btn-neutral"]] [
            text "<- Category"
          ]
        ],
        Grid.col [Col.xsAuto] [
          let
            buttonText = "Next: Reward"
            buttonType = Button.primary
            campaignDetails = Maybe.map3 (CampaignDetails) fundingGoal campaignStartDate campaignEndDate
            completeStepThree campaignDetails = CompleteStepThree stepOne stepTwo (StepThreeComplete campaignDetails)
          in
            case campaignDetails of
              Nothing ->
                Button.button [buttonType, Button.disabled True] [
                  text buttonText
                ]
              Just campaignDetails ->
                Button.button [buttonType, Button.onClick (completeStepThree campaignDetails)] [
                  text buttonText
                ]
        ]
      ]
    ]
  ]

viewStepFour : StepOne -> StepTwo -> StepThree -> RewardDetailsProgress -> Html Msg
viewStepFour stepOne stepTwo stepThree progress =
  let
    {
      title,
      pledgeAmount,
      description,
      estimatedDeliveryMonth,
      estimatedDeliveryYear
    } = progress
  in
    Grid.row [Row.centerXs, Row.attrs [Spacing.pt5, Spacing.pb5]] [
    Grid.col [Col.xs6, Col.middleXs] [
      h2 [Spacing.mb0, class "text-center"] [
        text "Inital reward for early backers."
      ],
      h4 [class "text-muted text-center", Spacing.mt1] [
        text "And don’t worry, you can edit this later, too."
      ],
      Form.group [] [
        Form.label [for "step-four-title-input"] [
          text "Title"
        ],
        Input.text [
          Input.id "step-four-title-input",
          Input.placeholder "Briefly describe this reward",
          Input.onInput (String.nonEmpty >> RewardTitleUpdated)
        ]
      ],
      Form.group [] [
        Form.label [for "step-four-pledge-amount-input"] [
          text "Pledge amount"
        ],
        Input.number [
          Input.id "step-four-pledge-amount-input",
          Input.placeholder "Set a pledge amount for this reward",
          Input.onInput (String.toFloat >> Result.toMaybe >> Maybe.andThen Number.nonZeroFloat >> RewardPledgeAmountUpdated)
        ]
      ],
      Form.group [] [
        Form.label [for "step-four-description-textarea"] [
          text "Description"
        ],
        Textarea.textarea [
          Textarea.id "step-four-description-textarea",
          Textarea.rows 3,
          Textarea.onInput (String.nonEmpty >> RewardDescriptionUpdated),
          Textarea.attrs [placeholder "Describe this reward in more detail", class "p-2"]
        ]
      ],
      Form.group [] [
        Form.label [for "step-four-deliver-fields"] [
          text "Estimated Delivery",
          small [] [
            text "Give yourself plenty of time. It's better to deliver to backers ahead of schedule than behind."
          ]
        ],
        Form.row [] [
          Form.col [Col.lg6, Col.xs12] [
            Select.select [
              Select.id "step-four-month-select",
              Select.onChange (monthFromString >> RewardDeliveryMonthUpdated),
              Select.large
            ] [
              Select.item [] [ text "Month" ],
              Select.item [ value (toString Date.Jan) ] [text "January"],
              Select.item [ value (toString Date.Feb) ] [text "February"],
              Select.item [ value (toString Date.Mar) ] [text "March"],
              Select.item [ value (toString Date.Apr) ] [text "April"],
              Select.item [ value (toString Date.May) ] [text "May"],
              Select.item [ value (toString Date.Jun) ] [text "June"],
              Select.item [ value (toString Date.Jul) ] [text "July"],
              Select.item [ value (toString Date.Aug) ] [text "August"],
              Select.item [ value (toString Date.Sep) ] [text "September"],
              Select.item [ value (toString Date.Oct) ] [text "October"],
              Select.item [ value (toString Date.Nov) ] [text "November"],
              Select.item [ value (toString Date.Dec) ] [text "December"]
            ]
          ],
          Form.col [Col.lg6, Col.xs12] [
            Select.select [
              Select.id "step-four-year-select",
              Select.onChange (String.toInt >> Result.toMaybe >> RewardDeliveryYearUpdated),
              Select.large
            ] [
              Select.item [] [ text "Year" ],
              Select.item [ value "2018" ] [text "2018"],
              Select.item [ value "2019" ] [text "2019"],
              Select.item [ value "2020" ] [text "2020"],
              Select.item [ value "2021" ] [text "2021"],
              Select.item [ value "2022" ] [text "2022"]
            ]
          ]
        ]
      ],
      hr [Spacing.mt5] [],
      Grid.row [Row.betweenXs] [
        Grid.col [Col.xsAuto] [
          Button.button [Button.onClick (ChangeActiveStep StepOne), Button.attrs [class "btn-neutral"]] [
            text "<- Category"
          ]
        ],
        Grid.col [Col.xsAuto] [
          let
            buttonText = "Complete"
            buttonType = Button.primary
            estimatedDelivery =
              Maybe.map2 (\month year ->
                0
                  |> Date.fromTime
                  |> DateField.fieldToDate (DateField.Month month)
                  |> Maybe.map (DateField.fieldToDate (DateField.Year year))
                  |> Maybe.join
              ) estimatedDeliveryMonth estimatedDeliveryYear
              |> Maybe.join
              |> Maybe.map Date.toTime

            rewardDetails = Maybe.map4 (RewardDetails) title pledgeAmount description estimatedDelivery
            completeStepFour rewardDetails = CompleteCampaign stepOne stepTwo stepThree (StepFourComplete rewardDetails)
          in
            case rewardDetails of
              Nothing ->
                Button.button [buttonType, Button.disabled True] [
                  text buttonText
                ]
              Just rewardDetails ->
                Button.button [buttonType, Button.onClick (completeStepFour rewardDetails)] [
                  text buttonText
                ]
        ]
      ]
    ]
  ]