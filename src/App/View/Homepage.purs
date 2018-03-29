module App.View.Homepage where

import Prelude

import App.Events (Event(..))
import App.State (State(..))
import Data.Int (decimal, toStringAs)
import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, div, h1)
import Text.Smolder.Markup ((#!), text)


getCountString :: State -> String
getCountString (State s) = toStringAs decimal s.count

view :: State -> HTML Event
view s =
  div do
    h1 $ text "Upscrole" 
    div do
      button #! onClick (const Increment) $ text "Increment"
      h1 $ text (getCountString s)
      button #! onClick (const Decrement) $ text "Decrement"
