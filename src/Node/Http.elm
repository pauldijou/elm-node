module Node.Http exposing
  ( Options
  , createServer
  )

{-|

@docs Options, createServer

-}

import Dict
import Json.Encode
import Json.Decode as Decode exposing (Decoder)
import Server exposing (Server, Replier, Header, Cookie)
import Server.Method
import Server.Request exposing (Request)

import Native.Node.Http

{-|-}
type alias Options =
  { host: String
  , port_: Int
  }

{-|-}
createServer: Options -> Server
createServer options =
  { implementation = Native.Node.Http.createServer (encodeOptions options)
  , request =
    { decoder = requestDecoder
    }
  , replier =
    { init = init
    , withStatusCode = withStatusCode
    , withHeader = withHeader
    , withCookie = withCookie
    , withBody = withBody
    , send = send
    }
  }

-- ----------------------------------------------------------------------------
-- Internals

init: Replier -> Replier
init =
  Native.Node.Http.init

withStatusCode: Int -> Replier -> Replier
withStatusCode =
  Native.Node.Http.withStatusCode

withHeader: Header -> Replier -> Replier
withHeader header =
  Native.Node.Http.withHeader (encodeHeader header)

withCookie: Cookie -> Replier -> Replier
withCookie cookie replier =
  -- We do not support cookies for now
  replier

withBody: String -> Replier -> Replier
withBody =
  Native.Node.Http.withBody

send: Bool -> Replier -> Replier
send =
  Native.Node.Http.send

encodeOptions: Options -> Json.Encode.Value
encodeOptions options =
  Json.Encode.object
    [ ("host", Json.Encode.string options.host)
    , ("port", Json.Encode.int options.port_)
    ]

encodeHeader: Header -> Json.Encode.Value
encodeHeader header =
  Json.Encode.object
    [ ("name", Json.Encode.string header.name)
    , ("value", Json.Encode.string header.value)
    ]

requestDecoder: Decoder Request
requestDecoder =
  Decode.map7 Request
    (Decode.field "method" Server.Method.decoderUpper)
    (Decode.field "url" Decode.string)
    (Decode.field "headers" <| Decode.dict Decode.string)
    (Decode.succeed Dict.empty)
    (Decode.succeed Dict.empty)
    (Decode.succeed Dict.empty)
    (Decode.maybe <| Decode.field "body" Decode.string)
