module App.Types where
  
type Message = { body :: String, avatar :: String, created_at :: String, nickname :: String, room_id :: String}
type Messages = Array Message
