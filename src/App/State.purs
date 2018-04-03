module App.State where

import App.Config (config)
import App.Routes (Route, match)
import App.Types (Messages)
import Data.Newtype (class Newtype)
import Data.Maybe (Maybe(..))
import Control.SocketIO.Client (Socket)

newtype State = State
  { title :: String
  , route :: Route
  , loaded :: Boolean
  , messages :: Messages
  , messageInput :: String
  , socket :: Maybe Socket
  }

derive instance newtypeState :: Newtype State _

init :: String -> Socket -> State
init url socket = State
  { title: config.title
  , route: match url
  , loaded: false
  , messages: []
  , messageInput: ""
  , socket: Just socket
  }
