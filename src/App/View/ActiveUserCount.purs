module App.View.ActiveUserCount where

import Prelude (($), (<>))

import App.Events (Event)
import App.State (State(..))
import Data.Int (toStringAs, decimal)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div)
import Text.Smolder.Markup (text)

getInputText :: State -> String
getInputText (State s) = s.messageInput

activeUserString :: Int -> String
activeUserString count = "There are " <> (toStringAs decimal count) <> " active users"

activeUserCount :: State -> HTML Event
activeUserCount (State s) =
  div $ text $ activeUserString s.activeUsers
