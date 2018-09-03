module CreateDaico.View exposing (view)

import CreateDaico.Model as Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block

view : Model -> Html Msg
view model = 
  div [ class "image-container set-full-height", attribute "style" "background-image: url('assets/img/wizard-book.jpg')" ] [
    logo,
    attribution,
    Grid.container [] [
      Grid.row [] [
        Grid.col [Col.sm8, Col.offsetSm2] [
          div [class "wizard-container"] [
            Card.config [Card.attrs [class "wizard-card", attribute "data-color" "red", id "wizard"]]
              |> Card.block [] [
                  Block.custom <|
                  Html.form [ action "", method "" ] [
                    header,
                    navigation,
                    div [ class "tab-content" ] [ 
                      div [] [
                        case model.activeFormSection of
                          Description ->
                            descriptionForm
                          Tokensale ->
                            tokenSaleForm
                          Funding ->
                            fundingForm
                          Voting ->
                            votingForm
                          Charity ->
                            charityForm
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
    ul [] [
      li [] [
        a [attribute "data-toggle" "tab", href "#description", onClick (UpdateFormSection Description)] [
          text "Description"
        ]
      ],
      li [] [
        a [attribute "data-toggle" "tab", href "#tokensale", onClick (UpdateFormSection Tokensale)] [
          text "Tokensale"
        ]
      ],
      li [] [
        a [attribute "data-toggle" "tab", href "#funding", onClick (UpdateFormSection Funding)] [
          text "Funding"
        ]
      ],
      li [] [
        a [attribute "data-toggle" "tab", href "#voting", onClick (UpdateFormSection Voting)] [
          text "Voting"
        ]
      ],
      li [] [
        a [attribute "data-toggle" "tab", href "#charity", onClick (UpdateFormSection Charity)] [
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

attribution : Html Msg
attribution =
  a [class "made-with-mk", href "http://demos.creative-tim.com/material-kit/index.html?ref=material-bootstrap-wizard" ] [
    div [ class "brand" ] [
      text "MK"
    ],
    div [ class "made-with" ] [
      strong [] [
        text "Material Kit"
      ]
    ]
  ]

descriptionForm : Html Msg
descriptionForm =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Let's start with the basic details."
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Name"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "The name of your project"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ],
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Description"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "A description of your project"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ],
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Url"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "A link to your project"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ],
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Whitepaper Url"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "A link to your whitepaper"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ]
  ]

tokenSaleForm : Html Msg
tokenSaleForm =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Now let's configure your token sale."
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Token Name"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "The name of your Token"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ],
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Symbol"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "Token Symbol"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm6] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Toke Supply"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "Total supply of your token"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm6] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Tokensale Allocation"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "How many tokens of the total supply will be distributed during your token sale?"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Token Value"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "How much is your token worth in EOS"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Softcap"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "Minimum funds to raise during your tokensale"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Hardcap"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "The upper limit of funds to raise during your tokensale"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Start Date"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "When does your tokensale begin?"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "End Date"
          ]
        ],
        div [class "form-group label-floating m-0 w-75"] [
          label [class "control-label"] [
            text "When does your tokensale end?"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ]
  ]

fundingForm : Html Msg
fundingForm =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Your funding schedule is a critical piece of your DAICO!"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Token Sale Start"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Length of time after token sale to begin initial funding cycle"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Funding cycle period"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "How long would you like each funding cycle to be?"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]  
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Initial Tap"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "How large will your initial funding cycle be?"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]  
      ]
    ]
  ]

votingForm : Html Msg
votingForm =
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
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Minimum Turnout"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Minimum Voter Turnout as % of previous voter turnout"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Pass Threshold"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Minimum Vote Yes % for vote pass"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Maximum Tap Increase"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "% Max tap increase relative to current tap (Optional)"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Vote Duration"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Tap Increase Voting Period Duration (Min: 3 days)"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
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
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Refund Election Frequency"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "How frequently can refund elections be activated"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Max Elections"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Max number of refund elections (optional)"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Voting Duration"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Election Voting Duration (Min: 1 month)"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Minimum Turnout"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Minimum Voter Turnout as % of previous voter turnout"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Pass Threshold"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Minimum Vote Yes % for vote pass"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ]
  ]

charityForm : Html Msg
charityForm =
  Grid.row [] [
    Grid.col [Col.sm12] [
      h4 [class "info-text"] [
        text "Charity Daico"
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Allocation"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "% of Tokensale allocated to Charity DAICO"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Number of charities"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "# of charities that you want it distributed to"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ],
    Grid.col [Col.sm12] [
      div [class "input-group"] [
        span [class "input-group-addon"] [
          i [class "material-icons"] [
            text "Duration"
          ]
        ],
        div [class "form-group label-floating"] [
          label [class "control-label"] [
            text "Charity DAICO duration"
          ],
          input [class "form-control", name "name", type_ "text"] []
        ]    
      ]
    ]
  ]