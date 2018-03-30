module App.View.MessageList where

import Prelude

import App.Events (Event)
import Data.Foldable (for_)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (ul, li)
import Text.Smolder.Markup (text)
import App.Types (Message, Messages)

message :: Message -> HTML Event
message m = li $ text m

messageList :: Messages -> HTML Event
messageList m =
  ul $ for_ m message
