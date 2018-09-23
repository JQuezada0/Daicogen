module DaicoTemplate.Update exposing (init, update, subscriptions)

import Response exposing (..)
import DaicoTemplate.Model as Model exposing (..)
import Ports
import Navigation
import Process
import Task

init : Response Model Msg
init =
  {
    activeFormSection = Description,
    template = {
      description = {
        name = "Collective Health",
        description = "Benefit from your medical data",
        url = "https://www.collectivehealth.io/",
        whitepaperUrl = "https://www.collectivehealth.io/whitepaper"
      },
      tokenSale = {
        tokenName = "CH Coin",
        tokenSymbol = "CHB",
        tokenSupply = "1500000",
        tokenValue = 10,
        tokenSaleAllocation = "1000000",
        softCap = 500000,
        hardCap = 750000,
        startDate = 1538348400000,
        endDate = 1540944000000
      },
      voting = {
        tapPoll = {
          minimumTurnout = 25,
          threshold = 75,
          maxTapIncrease = 25,
          voteDuration = 864000
        },
        refundPoll = {
          refundElectionFrequency = 7884000000,
          maxElections = 10,
          votingDuration = 1540944000000,
          minimumTurnout = 50,
          threshold = 80
        }
      },
      charity = {
        allocation = 10,
        numberOfCharities = 5,
        duration = 864000
      },
      funding = {
        tokenSaleStart = 1546300800000,
        fundingCyclePeriod = 7884000000,
        initialTap = "$500000"
      }
    }
  }
    |> withNone

update : Msg -> Model -> Response Model Msg
update msg model =
  case msg of
    UpdateFormSection formSection ->
      { model |
        activeFormSection = formSection
      }
        |> withNone

    UpdateDetail (UpdateName name) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                description = 
                  t.description 
                    |> (\d -> { d | name = name })
          })
      }
        |> withNone

    UpdateDetail (UpdateDescription description) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                description = 
                  t.description 
                    |> (\d -> { d | description = description })
          })
      }
        |> withNone

    UpdateDetail (UpdateUrl url) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                description = 
                  t.description 
                    |> (\d -> { d | url = url })
          })
      }
        |> withNone

    UpdateDetail (UpdateWhitepaperUrl whitepaperUrl) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                description = 
                  t.description 
                    |> (\d -> { d | whitepaperUrl = whitepaperUrl })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateTokenName name) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | tokenName = name })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateTokenSymbol symbol) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | tokenSymbol = symbol })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateTokenSupply supply) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | tokenSupply = supply })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateTokenValue value) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | tokenValue = value })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateSoftCap softCap) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | softCap = softCap })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateHardCap hardCap) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | hardCap = hardCap })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateStartDate startDate) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | startDate = startDate })
          })
      }
        |> withNone

    UpdateTokenSale (UpdateEndDate endDate) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                tokenSale = 
                  t.tokenSale 
                    |> (\ts -> { ts | endDate = endDate })
          })
      }
        |> withNone

    UpdateVoting (UpdateTapMinimumTurnout minimumTurnout) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | tapPoll = 
                      v.tapPoll
                        |> (\tp -> { tp | minimumTurnout = minimumTurnout })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateTapThreshold threshold) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | tapPoll = 
                      v.tapPoll
                        |> (\tp -> { tp | threshold = threshold })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateTapMaxIncrease maxTapIncrease) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | tapPoll = 
                      v.tapPoll
                        |> (\tp -> { tp | maxTapIncrease = maxTapIncrease })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateTapVoteDuration voteDuration) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | tapPoll = 
                      v.tapPoll
                        |> (\tp -> { tp | voteDuration = voteDuration })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateRefundElectionFrequency frequency) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | refundPoll = 
                      v.refundPoll
                        |> (\rp -> { rp | refundElectionFrequency = frequency })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateRefundMaxElections maxElections) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | refundPoll = 
                      v.refundPoll
                        |> (\rp -> { rp | maxElections = maxElections })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateRefundVotingDuration votingDuration) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | refundPoll = 
                      v.refundPoll
                        |> (\rp -> { rp | votingDuration = votingDuration })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateRefundMinimumTurnout minimumTurnout) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | refundPoll = 
                      v.refundPoll
                        |> (\rp -> { rp | minimumTurnout = minimumTurnout })
                    })
          })
      }
        |> withNone

    UpdateVoting (UpdateRefundThreshold threshold) ->
      { model | template =
          model.template
            |> (\t ->  { t | 
                voting = 
                  t.voting
                    |> (\v -> { v | refundPoll = 
                      v.refundPoll
                        |> (\rp -> { rp | threshold = threshold })
                    })
          })
      }
        |> withNone

    UpdateCharity (UpdateAllocation allocation) ->
      { model | template =
          model.template
            |> (\t -> { t | 
              charity =
                t.charity
                  |> (\c -> { c | allocation = allocation })
            })
      }
        |> withNone

    UpdateCharity (UpdateNumberOfCharities charities) ->
      { model | template =
          model.template
            |> (\t -> { t | 
              charity =
                t.charity
                  |> (\c -> { c | numberOfCharities = charities })
            })
      }
        |> withNone

    UpdateCharity (UpdateDuration duration) ->
      { model | template =
          model.template
            |> (\t -> { t | 
              charity =
                t.charity
                  |> (\c -> { c | duration = duration })
            })
      }
        |> withNone

    SubmitTemplate ->
      let
        cmd =
          Process.sleep 1000
            |> Task.andThen (always (Task.succeed Reload))
            |> Task.perform identity
      in
        model
          |> withCmd (Cmd.batch [Ports.submitTemplate model.template, cmd])

    Reload ->
      model
        |> withCmd Navigation.reload

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
