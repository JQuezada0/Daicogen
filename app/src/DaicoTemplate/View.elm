module DaicoTemplate.View exposing (view)

import DaicoTemplate.Model as Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Button as Button
import Date
import Time.Format as Time

view : Model -> Html Msg
view model = 
  div [ class "image-container set-full-height", style [("background-color", "#1c293a")]] [
    Grid.container [] [
      Grid.row [] [
        Grid.col [Col.sm6, Col.offsetSm2] [
          div [style [("padding-top", "100px")]] [
            img [src "assets/img/daicogen-logo.png", width 450] []
          ]
        ],
        Grid.col [Col.sm6, Col.offsetSm2] [
          div [class "wizard-container"] [
            Card.config [Card.attrs [class "wizard-card", attribute "data-color" "red", id "wizard"]]
              |> Card.block [] [
                  Block.custom <|
                  Html.form [ action "", method "" ] [
                    navigation,
                    div [ class "tab-content" ] [
                      div [] [
                        case model.activeFormSection of
                          Description ->
                            descriptionForm model.template.description
                          Tokensale ->
                            tokenSaleForm model.template.tokenSale
                          Funding ->
                            fundingForm model.template.funding
                          Voting ->
                            votingForm model.template.voting
                          Charity ->
                            charityForm model.template.charity
                      ]
                    ]
                ]
              ]
              |> Card.view
          ]
        ]
      ]
    ]
  ]

header : Html Msg
header =
  div [ class "wizard-header" ] [
    h3 [class "wizard-title"] [
      text "Initiate a DACIO"
    ],
    h5 [] [
      text "This will setup the parameters that your DAICO will be generated with"
    ]
  ]

navigation : Html Msg
navigation =
  div [ class "wizard-navigation" ] [
    div [class "progress-with-circle"] [
      div [class "progress-bard", attribute "role" "progressbar", style [("width" ,"21%")]] []
    ],
    ul [class "nav nav-pills"] [
      li [style [("width" ,"20%")]] [
        a [attribute "data-toggle" "tab", href "#description", onClick (UpdateFormSection Description)] [
          div [class "icon-circle", style [("display", "table")]] [
            div [style [("display", "table-cell"), ("vertical-align", "middle")]] [
              i [class "nc-icon nc-ruler-pencil"] []
            ]
          ],
          text "Description"
        ]
      ],
      li [style [("width" ,"20%")]] [
        a [attribute "data-toggle" "tab", href "#tokensale", onClick (UpdateFormSection Tokensale)] [
          div [class "icon-circle", style [("display", "table")]] [
            div [style [ ("display", "table-cell"), ("vertical-align", "middle") ]] [
              i [class "nc-icon nc-money-coins"] []
            ]
          ],
          text "Tokensale"
        ]
      ],
      li [style [("width" ,"20%")]] [
        a [attribute "data-toggle" "tab", href "#funding", onClick (UpdateFormSection Funding)] [
          div [class "icon-circle", style [("display", "table")]] [
            div [style [("display", "table-cell"), ("vertical-align", "middle")]] [
              i [class "nc-icon nc-shop"] []
            ]
          ],
          text "Funding"
        ]
      ],
      li [style [("width" ,"20%")]] [
        a [attribute "data-toggle" "tab", href "#voting", onClick (UpdateFormSection Voting)] [
          div [class "icon-circle", style [("display", "table")]] [
            div [style [("display", "table-cell"), ("vertical-align", "middle")]] [
              i [class "nc-icon nc-paper"] []
            ]
          ],
          text "Voting"
        ]
      ],
      li [style [("width" ,"20%")]] [
        a [attribute "data-toggle" "tab", href "#charity", onClick (UpdateFormSection Charity)] [
          div [class "icon-circle", style [("display", "table")]] [
            div [style [("display", "table-cell"), ("vertical-align", "middle")]] [
              i [class "nc-icon nc-planet"] []
            ]
          ],
          text "Charity"
        ]
      ]
    ]
  ]                   

logo : Html Msg
logo =
  a [ href "http://daicogen.com" ] [
    div [class "logo-container"] [
      div [class "logo"] [
        img [ src "assets/img/new_logo.png" ] []
      ],
      div [ class "brand" ] [
        text "Daicogen"
      ]
    ]
  ]

descriptionForm : DescriptionParams -> Html Msg
descriptionForm params =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Let's start with the basic details."
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group label-floating"] [
        label [] [
          text "Name"
        ],
        input [class "form-control", name "projectName", value params.name, type_ "text", onInput (UpdateName >> UpdateDetail)] []
      ],
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Description"
        ],
        input [class "form-control", name "projectDescription", value params.description, type_ "text", onInput (UpdateDescription >> UpdateDetail)] []
      ],
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Url"
        ],
        input [class "form-control", name "projectUrl", value params.url, type_ "text", onInput (UpdateUrl >> UpdateDetail)] []
      ],
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Whitepaper Url"
        ],
        input [class "form-control", name "projectWhitepaper", value params.whitepaperUrl, type_ "text", onInput (UpdateWhitepaperUrl >> UpdateDetail)] []
      ]
    ]
  ]

tokenSaleForm : TokenSaleParams -> Html Msg
tokenSaleForm params =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Now let's configure your token sale."
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "The name of your Token"
        ],
        input [class "form-control", name "tokenName", value params.tokenName, type_ "text", onInput (UpdateTokenName >> UpdateTokenSale)] []
      ],
      div [class "form-group"] [
        label [class "control-label"] [
          text "Token Symbol"
        ],
        input [class "form-control", name "tokenSymbol", value params.tokenSymbol, type_ "text", onInput (UpdateTokenSymbol >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm6] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Total supply of your token"
        ],
        input [class "form-control", name "tokenSupply", value params.tokenSupply, type_ "text", onInput (UpdateTokenSupply >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm6] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Allocation"
        ],
        input [class "form-control", name "tokenAllocation", value (params.tokenSaleAllocation), type_ "text"] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "How much is your token worth in EOS"
        ],
        input [class "form-control", name "tokenValue", value (toString params.tokenValue), type_ "text", onInput (String.toInt >> Result.withDefault 0 >> UpdateTokenValue >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Minimum funds to raise during your tokensale"
        ],
        input [class "form-control", name "softCap", value (toString params.softCap), type_ "text", onInput (String.toInt >> Result.withDefault 0 >> UpdateSoftCap >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "The upper limit of funds to raise during your tokensale"
        ],
        input [class "form-control", name "hardCap", value (toString params.hardCap), type_ "text", onInput (String.toInt >> Result.withDefault 0 >> UpdateHardCap >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "When does your tokensale begin?"
        ],
        input [class "form-control", name "tokensaleStartDate", value (Time.format "%d/%m/%Y" params.startDate), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateStartDate >> UpdateTokenSale)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "When does your tokensale end?"
        ],
        input [class "form-control", name "tokenSaleEndDate", value (Time.format "%d/%m/%Y" params.endDate), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateEndDate >> UpdateTokenSale)] []
      ]
    ]
  ]

fundingForm : FundingParams -> Html Msg
fundingForm params =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Your funding schedule is a critical piece of your DAICO!"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Length of time after token sale to begin initial funding cycle"
        ],
        input [class "form-control", name "fundingStart", value (Time.format "%d/%m/%Y" params.tokenSaleStart), type_ "text"] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "How long would you like each funding cycle to be?"
        ],
        input [class "form-control", name "fundingCycleLength", value (Time.format "%d/%m/%Y"  params.fundingCyclePeriod), type_ "text"] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "How large will your initial funding cycle be?"
        ],
        input [class "form-control", name "initialFundingCycleLength", value (toString params.initialTap), type_ "text"] []
      ]  
    ]
  ]

votingForm : VotingParams -> Html Msg
votingForm params =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Set your voting parameters"
      ]
    ],
    Grid.col [Col.sm12] [
      h5 [class "info-text"] [
        text "Tap Poll"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Minimum Voter Turnout as % of previous voter turnout"
        ],
        input [class "form-control", name "tapMinimumTurnout", value (toString params.tapPoll.minimumTurnout), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateTapMinimumTurnout >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Minimum Vote Yes % for vote pass"
        ],
        input [class "form-control", name "tapThreshold", type_ "text", value (toString params.tapPoll.threshold), onInput (String.toFloat >> Result.withDefault 0 >> UpdateTapThreshold >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "% Max tap increase relative to current tap (Optional)"
        ],
        input [class "form-control", name "tapIncreasePercent", value (toString params.tapPoll.maxTapIncrease), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateTapMaxIncrease >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Tap Increase Voting Period Duration (Min: 3 days)"
        ],
        input [class "form-control", name "tapDuration", value (toString params.tapPoll.voteDuration), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateTapVoteDuration >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      hr [] []
    ],
    Grid.col [Col.sm12] [
      h5 [class "info-text"] [
        text "Refund Poll"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "How frequently can refund elections be activated"
        ],
        input [class "form-control", name "refundVoteFrequency", value (toString params.refundPoll.refundElectionFrequency), type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateRefundElectionFrequency >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Max number of refund elections (optional)"
        ],
        input [class "form-control", name "refundVoteMax", value (toString params.refundPoll.maxElections), type_ "text", onInput (String.toInt >> Result.withDefault 0 >> UpdateRefundMaxElections >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Election Voting Duration (Min: 1 month)"
        ],
        input [class "form-control", name "refundVoteDuration", value (toString params.refundPoll.votingDuration),type_ "text", onInput (String.toFloat >> Result.withDefault 0 >> UpdateRefundVotingDuration >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Minimum Voter Turnout as % of previous voter turnout"
        ],
        input [class "form-control", name "refundMinimumTurnout", type_ "text", value (toString params.refundPoll.minimumTurnout), onInput (String.toFloat >> Result.withDefault 0 >> UpdateRefundMinimumTurnout >> UpdateVoting)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group label-floating"] [
        label [class "control-label"] [
          text "Minimum Vote Yes % for vote pass"
        ],
        input [class "form-control", name "refundThreshold", type_ "text",value (toString params.refundPoll.threshold), onInput (String.toFloat >> Result.withDefault 0 >> UpdateRefundThreshold >> UpdateVoting)] []
      ]
    ]
  ]

charityForm : CharityParams -> Html Msg
charityForm params =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Charity Daico"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "% of Tokensale allocated to Charity DAICO"
        ],
        input [class "form-control", name "name", type_ "text", value (toString params.allocation), onInput (String.toFloat >> Result.withDefault 0 >> UpdateAllocation >> UpdateCharity)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "# of charities that you want it distributed to"
        ],
        input [class "form-control", name "name", type_ "text", value (toString params.numberOfCharities), onInput (String.toInt >> Result.withDefault 0 >> UpdateNumberOfCharities >> UpdateCharity)] []
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "form-group"] [
        label [class "control-label"] [
          text "Charity DAICO duration"
        ],
        input [class "form-control", name "name", type_ "text", value (toString params.duration), onInput (String.toFloat >> Result.withDefault 0 >> UpdateDuration >> UpdateCharity)] []
      ]
    ],
    Grid.col [Col.sm12] [
      Button.button [Button.primary, Button.onClick SubmitTemplate] [
        text "Submit"
      ]
    ]
  ]