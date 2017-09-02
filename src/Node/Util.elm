module Node.Util exposing
  ( Options
  , defaultOptions
  , inspect
  , inspectLog
  )

{-|
Node API: https://nodejs.org/docs/latest/api/util.html

The util module is primarily designed to support the needs of Node.js' own internal APIs. However, many of the utilities are useful for application and module developers as well.

@docs Options, defaultOptions, inspect, inspectLog
-}

import Json.Encode as Encode

import Node.Types exposing (Depth)
import Node.Internals as Internals exposing (encodeMaybeField, encodeDepth)
import Native.Node.Util


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


-- -----------------------------------------------------------------------------
-- JSON

encodeOptions: Options -> Encode.Value
encodeOptions options =
  [ encodeMaybeField "showHidden" Encode.bool options.showHidden
  , encodeMaybeField "depth" encodeDepth options.depth
  , encodeMaybeField "colors" Encode.bool options.colors
  , encodeMaybeField "customInspect" Encode.bool options.customInspect
  , encodeMaybeField "showProxy" Encode.bool options.showProxy
  , encodeMaybeField "maxArrayLength" Encode.int options.maxArrayLength
  , encodeMaybeField "breakLength" Encode.int options.breakLength
  ]
  |> List.filterMap identity
  |> Encode.object

encodeMaybeOptions: Maybe Options -> Encode.Value
encodeMaybeOptions =
  (Maybe.map encodeOptions) >> (Maybe.withDefault Encode.null)
