module App.View.ChatInput where

import Prelude

import App.Events (Event(..))
import App.State (State(..))
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onChange, onClick)
import Text.Smolder.HTML (div, input, button)
import Text.Smolder.HTML.Attributes (type', value)
import Text.Smolder.Markup (text, (!), (#!))

getInputText :: State -> String
getInputText (State s) = s.messageInput

chatInput :: State -> HTML Event
chatInput (State s) =
  div do
    input ! type' "text" ! value s.messageInput #! onChange MessageInputChange
    button #! onClick (const MessageSubmit) $ text "submit" 
