module Node.Util exposing
  ( Depth(Depth, Infinite)
  , Options
  , defaultOptions
  , inspect
  , inspectLog
  )

{-| The util module is primarily designed to support the needs of Node.js' own internal APIs. However, many of the utilities are useful for application and module developers as well.

@docs Depth, Options, defaultOptions, inspect, inspectLog

-}

import Json.Encode as Encode

import Node.Helpers as H
import Native.Node.Util

{-| Specifies the number of times to recurse while formatting the object. This is useful for inspecting large complicated objects. -}
type Depth = Depth Int | Infinite


{-| Check https://nodejs.org/docs/latest/api/util.html#util_util_inspect_object_options -}
type alias Options =
  { showHidden: Maybe Bool
  , depth: Maybe Depth
  , colors: Maybe Bool
  , customInspect: Maybe Bool
  , showProxy: Maybe Bool
  , maxArrayLength: Maybe Int
  , breakLength: Maybe Int
  }

{-| Empty options, all Node defaults -}
defaultOptions: Options
defaultOptions =
  { showHidden = Nothing
  , depth = Nothing
  , colors = Nothing
  , customInspect = Nothing
  , showProxy = Nothing
  , maxArrayLength = Nothing
  , breakLength = Nothing
  }

{-| Stringify any object. Support recursive values -}
inspect: Maybe Options -> a -> String
inspect options value =
  Native.Node.Util.inspect value (encodeMaybeOptions options)

{-| Just like `Debug.log` but using inspect -}
inspectLog: Maybe Options -> a -> a
inspectLog options value =
  Native.Node.Util.inspectLog value (encodeMaybeOptions options)


encodeDepth: Depth -> Encode.Value
encodeDepth depth =
  case depth of
    Depth int -> Encode.int int
    Infinite  -> Encode.null

encodeOptions: Options -> Encode.Value
encodeOptions options =
  [ H.encodeMaybeField "showHidden" Encode.bool options.showHidden
  , H.encodeMaybeField "depth" encodeDepth options.depth
  , H.encodeMaybeField "colors" Encode.bool options.colors
  , H.encodeMaybeField "customInspect" Encode.bool options.customInspect
  , H.encodeMaybeField "showProxy" Encode.bool options.showProxy
  , H.encodeMaybeField "maxArrayLength" Encode.int options.maxArrayLength
  , H.encodeMaybeField "breakLength" Encode.int options.breakLength
  ]
  |> List.filterMap identity
  |> Encode.object

encodeMaybeOptions: Maybe Options -> Encode.Value
encodeMaybeOptions =
  (Maybe.map encodeOptions) >> (Maybe.withDefault Encode.null)
