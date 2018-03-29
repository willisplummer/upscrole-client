module App.Events where

import App.Routes (Route)
import App.State (State(..))
import Data.Function (($))
import Data.Ring ((+), (-))
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects)

data Event = Increment | Decrement | PageView Route

type AppEffects fx = (ajax :: AJAX | fx)

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (Increment) (State st) = noEffects $ State st { count = st.count + 1}
foldp (Decrement) (State st) = noEffects $ State st { count = st.count - 1}
