module App.Events where
import App.Routes (Route)
import App.State (State(..))
import App.Types (Messages, Message)
import Control.Applicative (pure)
import Control.Apply ((*>))
import Control.Monad.Aff.Console (log)
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.List.Trans (fromEffect)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.SocketIO.Client (emit, Event, SocketIO) as Socket
import Data.Array (snoc, head)
import Data.Function (($))
import Data.Maybe (Maybe(..), fromMaybe)
import Network.HTTP.Affjax (AJAX)
import Prelude ((>>=), unit, bind, Unit)
import Pux (EffModel, noEffects)
import Pux.DOM.Events (DOMEvent, targetValue)

dataEvent :: Socket.Event
dataEvent = "data"

data Event = PageView Route | MessageInputChange DOMEvent | MessageSubmit | OnMessage Messages | Noop

type AppEffects fx = (ajax :: AJAX, console :: CONSOLE, socket :: Socket.SocketIO | fx)

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (MessageInputChange e) (State st) = noEffects $ State st { messageInput = targetValue e }
foldp (MessageSubmit) (State st) =
  { state: State st { messageInput = "" }
  , effects: [
    case st.socket of
      Just socket -> liftEff $ Socket.emit socket dataEvent st.messageInput
      _ -> Noop
    ]
  }
foldp (MessageSubmit) (State st) = noEffects $ State st
foldp (OnMessage m) (State st) = noEffects $ State st {messages = m}
foldp Noop st = noEffects $ st
