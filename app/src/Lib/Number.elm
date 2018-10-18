module Lib.Number exposing (..)

nonZeroFloat : Float -> Maybe Float
nonZeroFloat float =
  if float > 0 then
    Just float
  else
    Nothing