module NodeServer exposing (..)

import Task
import Json.Decode

import Server exposing (Server, Replier, Response)
import Server.Response
import Error exposing (Error)
import Node.Http

type alias Model =
  { server: Server }

type Msg
  = Started (Result Error Server)
  | ServerMsg Server.Msg
  | Replied (Result Error Replier)

main: Program Never Model Msg
main =
  Platform.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    }

init: (Model, Cmd Msg)
init =
  let
    server = Node.Http.createServer { host = "localhost", port_ = 8000 }
  in
    { server = server } ! [ Task.attempt Started <| Server.start server ]

subscriptions: Model -> Sub Msg
subscriptions model =
  Server.listen ServerMsg

reply: Replier -> Response -> Cmd Msg
reply replier response =
  Task.attempt Replied (Server.reply replier response)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Started res ->
      let
        a = case res of
          Ok s -> Debug.log "Server" "started"
          Err e -> Debug.log "Failed to start server" e.message
      in
        model ! []

    ServerMsg (Server.Requested replier rawRequest) ->
      case Json.Decode.decodeValue model.server.request.decoder rawRequest of
        Err e ->
          let
            a = Debug.log ("Failed to parse request: " ++ e) rawRequest
          in
            model ! [ reply replier Server.Response.badRequest ]

        Ok request ->
          let
            a = Debug.log ("Request") (toString request)
          in
            model ! [ reply replier Server.Response.ok ]

    Replied res ->
      model ! []
