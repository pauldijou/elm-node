module Node.Console exposing
  ( defaultOptions
  , clear
  , defaultLabel
  , count
  , countReset
  , dir
  , dir2
  , error
  , info
  , log
  , time
  , timeEnd
  , trace
  , warn
  )

{-|
Node API: https://nodejs.org/api/console.html

@docs defaultOptions, clear, defaultLabel, count, countReset, dir, dir2, error, info, log, time, timeEnd, trace, warn
-}

import Json.Encode as Encode
import Node.Types as Types
import Node.Util as Util
import Node.Internals as Internals
import Native.Node.Console

type alias Options =
  { showHidden: Bool
  , depth: Types.Depth
  , colors: Bool
  }

{-| -}
defaultOptions: Options
defaultOptions =
  { showHidden = False
  , depth = Types.Depth 2
  , colors = False
  }

{-| -}
clear: a -> a
clear =
  Native.Node.Console.clear

{-| -}
defaultLabel: String
defaultLabel = "default"

{-| -}
count: String -> a -> a
count =
  Native.Node.Console.count

{-| -}
countReset: String -> a -> a
countReset =
  Native.Node.Console.countReset

{-| -}
dir: a -> a
dir =
  Native.Node.Console.dir

{-| -}
dir2: Options -> a -> a
dir2 options value =
  Native.Node.Console.dir2 (encodeOptions options) value

{-| -}
error: a -> a
error =
  Native.Node.Console.error

{-| -}
info: a -> a
info =
  Native.Node.Console.info

{-| -}
log: a -> a
log =
  Native.Node.Console.log

{-| -}
time: String -> a -> a
time =
  Native.Node.Console.time

{-| -}
timeEnd: String -> a -> a
timeEnd =
  Native.Node.Console.timeEnd

{-| -}
trace: String -> a -> a
trace =
  Native.Node.Console.trace

{-| -}
warn: a -> a
warn =
  Native.Node.Console.warn


-- -----------------------------------------------------------------------------
-- JSON

encodeOptions: Options -> Encode.Value
encodeOptions options =
  Encode.object
    [ ("showHidden", Encode.bool options.showHidden)
    , ("depth", Internals.encodeDepth options.depth)
    , ("colors", Encode.bool options.colors)
    ]
