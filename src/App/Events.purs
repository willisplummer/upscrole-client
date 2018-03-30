module App.Events where

import App.Routes (Route)
import App.State (State(..))
import Data.Function (($))
import Data.Ring ((+), (-))
import Data.Array (snoc)
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects)
import Pux.DOM.Events (DOMEvent, targetValue)

data Event = Increment | Decrement | PageView Route | MessageInputChange DOMEvent | MessageSubmit

type AppEffects fx = (ajax :: AJAX | fx)

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (Increment) (State st) = noEffects $ State st { count = st.count + 1}
foldp (Decrement) (State st) = noEffects $ State st { count = st.count - 1}
foldp (MessageInputChange e) (State st) = noEffects $ State st { messageInput = targetValue e }
foldp (MessageSubmit) (State st) = noEffects $ State st { messageInput = "", messages = snoc st.messages st.messageInput}
