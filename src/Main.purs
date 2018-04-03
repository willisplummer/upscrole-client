module Main where

import Prelude

import App.Events (AppEffects, Event(..), foldp)
import App.Routes (match)
import App.State (State, init)
import App.View.Layout (view)
import Control.Monad.Eff (Eff)
import Control.SocketIO.Client (SocketIO, Host, connect, on, Event) as Socket
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (HISTORY)
import Pux (CoreEffects, App, start)
import Pux.DOM.Events (DOMEvent)
import Pux.DOM.History (sampleURL)
import Pux.Renderer.React (renderToDOM)
import Signal (Signal, (~>))
import Signal.Channel (channel, send, subscribe)

type WebApp = App (DOMEvent -> Event) Event State

type ClientEffects = CoreEffects (AppEffects (history :: HISTORY, dom :: DOM, socket :: Socket.SocketIO))

hostname :: Socket.Host
hostname = "https://cryptic-plains-73206.herokuapp.com/?room=general"

messageEvent :: Socket.Event
messageEvent = "update chat"


main :: String -> State -> Eff ClientEffects WebApp
main url state = do
  -- | Create a signal of URL changes.
  -- urlSignal <- sampleURL =<< window
  urlSignal <- window >>= sampleURL

  -- | Map a signal of URL changes to PageView actions.
  let routeSignal = urlSignal ~> \r -> PageView (match r)
  -- let socketSignal = serverSignal ~> \m -> ServerEvent ()
  actionChannel <- channel Noop
  let socketSignal = subscribe actionChannel :: Signal Event
  socket <- Socket.connect hostname
  Socket.on socket messageEvent \d -> send actionChannel (OnMessage d)


  -- | Start the app.
  app <- start
    { initialState: init "/" socket
    , view
    , foldp
    , inputs: [routeSignal, socketSignal] }

  -- | Render to the DOM
  renderToDOM "#app" app.markup app.input

  -- | Return app to be used for hot reloading logic in support/client.entry.js
  pure app
