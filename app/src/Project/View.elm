module Project.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Project.Model exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Button as Button
import Bootstrap.Form.Select as Select
import Spinner
import Project.Api as Api

view : Model -> Html Msg
view model =
  model.project
    |> Maybe.andThen Result.toMaybe
    |> Maybe.map (\project ->
        viewSuccess model project
    )
    |> Maybe.withDefault Spinner.view

viewSuccess : Model -> Api.Project -> Html Msg
viewSuccess model project =
  div [ class "image-container set-full-height", style [("background-color", "#1c293a")]] [
    Grid.container [] [
      Grid.row [] [
        Grid.col [Col.sm6, Col.offsetSm2, Col.attrs [class "text-center", style [("color", "white")]]] [
          div [style [("padding-top", "100px")]] [
            img [src "assets/img/daicogen-logo.png", width 350] []
          ],
          h4 [] [
            text project.name
          ],
          p [] [
            text project.description
          ]
        ],
        Grid.col [Col.sm6, Col.offsetSm2] [
          div [class "wizard-container"] [
            Card.config [Card.attrs [class "wizard-card", attribute "data-color" "red", id "wizard"]]
              |> Card.block [] [
                  let
                    poll =
                      case project.polls of
                        [] -> Nothing
                        poll::rest -> Just poll
                  in
                    case poll of
                      Nothing ->
                        Block.custom (text "") -- Should never make it to this page without an exising poll
                      Just poll ->
                        Block.custom <|
                          div [] [
                            h2 [class "text-center mb-4"] [
                              case poll.proposal of
                                "FundsPerCycle" ->
                                  text "Increase Funding per Cycle"
                                _ ->
                                  text poll.proposal
                            ],
                            Grid.row [] [
                              Grid.col [Col.md6, Col.attrs [class "ml-auto mr-auto text-center"]] [
                                div [] [
                                  Select.select [ Select.id "userSelect", Select.onChange UpdateUserType ] [
                                    Select.item [ value "" ] [text "Select your account"],
                                    Select.item [ value (toString GeneralAccount)] [ text "General Account" ],
                                    Select.item [ value (toString IdAccount)] [ text "ID Verified Account" ]
                                  ]
                                ]
                              ]
                            ],
                            (
                              case model.selectedVotingMethod of
                                Nothing ->
                                  Grid.row [Row.attrs [class "text-center mt-2"]] [
                                    Grid.col [] [
                                      div [] [
                                        case model.selectedUserType of
                                          Nothing ->
                                            text ""
                                          Just userType ->
                                            div [] [
                                              viewUserTypeView model project userType
                                            ]
                                      ]
                                    ]
                                  ]
                                Just method ->
                                  div [] [
                                    Grid.row [Row.attrs [class "text-center mt-2"]] [
                                      let
                                        msg pick =
                                          case method of
                                            DelegateVote ->
                                              (SubmitSuggestion { icoaccount = "crowdsale", from = "delegate", to = "idaccount", pick = pick })
                                            IdAccountVote ->
                                              (SubmitVote { icoaccount = "crowdsale", idvoter = "idaccount", trvoter = "delegate", currentVoter = "idaccount", pick = pick })
                                      in
                                        Grid.col [] [
                                          Button.button [Button.primary, Button.onClick (msg True)] [
                                            text "Yes"
                                          ],
                                          Button.button [Button.primary, Button.onClick (msg False)] [
                                            text "No"
                                          ]
                                        ]
                                    ],
                                    Grid.row [Row.attrs [class "mt-2"]] [
                                      Grid.col [] [
                                        Button.button [Button.primary, Button.onClick (UpdateSelectedVotingMethod Nothing)] [
                                          text "Cancel"
                                        ]
                                      ]
                                    ]
                                  ]
                            )
                          ]
              ]
              |> Card.view
          ]
        ]
      ]
    ]
  ]
  -- div [class "wrapper"] [
  --   div [class "section profile-content"] [
  --     div [class "container"] [
  --       div [class "owner"] [
  --         div [class "avatar"] [
  --         ],
  --         div [class "name"] [
  --           h3 [class "title"] [
  --             text "Crypto Kitties"
  --           ],
  --           h5 [class "description"] [
  --             text "Funds per Cycle Increase Vote"
  --           ]
  --         ]
  --       ]
  --     ]
  --   ]
  -- ]

viewUserTypeView : Model -> Api.Project -> UserType -> Html Msg
viewUserTypeView model project userType =
  case userType of
    GeneralAccount ->
      let
        emptyUi = text "You don't have any proposed votes, please try logging in from a verified ID Account"
        alreadyVoted vote = text ("Congrats! You voted. Your choice was " ++ (
          if vote.pick then
            "Yes"
          else
            "No"
        ))
        proposalUi poll =
          case poll.voteProposals of
            [] ->
              emptyUi
            proposal::others ->
              div [] [
                h4 [] [
                  text "You have an open vote suggestion, do you agree?"
                ],
                h5 [] [
                  let
                    pick =
                      case proposal.pick of
                        True ->
                          "Yes"
                        False ->
                          "No"
                  in
                    text ("The vote was: " ++ pick)
                ],
                div [] [
                  Button.button [Button.primary, Button.onClick (SubmitVote { icoaccount = "crowdsale", trvoter = "delegate", idvoter = proposal.to, currentVoter = "delegate", pick = proposal.pick })] [
                    text "Agree"
                  ],
                  Button.button [Button.primary, Button.onClick (RemoveSuggestion { from = "crowdsale" })] [
                    text "Disagree"
                  ]
                ]
              ]
      in
      case project.polls of
        [] ->
          emptyUi
        poll::rest ->
          case poll.votes of
            vote::votes ->
              if vote.trvoter == "delegate" then
                alreadyVoted vote
              else
                proposalUi poll
            [] ->
              proposalUi poll
              
          
    IdAccount ->
      let
        emptyUi = 
          div [] [
            div [] [
              Button.button [Button.primary, Button.onClick (UpdateSelectedVotingMethod (Just IdAccountVote))] [
                text "Vote from my verified ID Account"
              ]
            ],
            div [class "mt-2"] [
              Button.button [Button.primary, Button.onClick (UpdateSelectedVotingMethod (Just DelegateVote))] [
                text "Propose a vote on behalf of an alternate account"
              ]
            ]
          ]
      in
        case project.polls of
          [] ->
            emptyUi
          poll::others ->
            case poll.voteProposals of
              [] ->
                emptyUi
              proposal::rest ->
                if proposal.to == "idaccount" then
                  div [] [
                    h4 [] [
                      text "Looks like you've already suggested a vote for an alternate account. Please confirm from your alternate account"
                    ],
                    Button.button [Button.danger, Button.onClick (RemoveSuggestion { from = "crowdsale" })] [
                      text "Revoke"
                    ]
                  ]
                else
                  case poll.votes of
                    [] ->
                      emptyUi
                    vote::rest ->
                      text ("Congrats! You voted. Your choice was " ++ (toString vote.pick))