module App.View.Homepage where

import Prelude

import App.Events (Event)
import App.State (State(..))
import App.Types (Messages)
import App.View.MessageList (messageList)
import App.View.ChatInput (chatInput)

import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, h1)
import Text.Smolder.Markup (text)

getMessages :: State -> Messages
getMessages (State s) = s.messages

view :: State -> HTML Event
view s =
  div do
    h1 $ text "Upscrole" 
    messageList (getMessages s)
    chatInput s

