module Node.Console exposing
  ( clear
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

@docs clear, defaultLabel, count, countReset, dir, dir2, error, info, log, time, timeEnd, trace, warn
-}

import Json.Encode as Encode
import Node.Util as Util
import Native.Node.Console

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
dir2: { showHidden: Bool, depth: Maybe Int, colors: Bool } -> a -> a
dir2 options value =
  Native.Node.Console.dir2 (encodeDir2 options) value

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

encodeDir2: { showHidden: Bool, depth: Util.Depth, colors: Bool } -> Encode.Value
encodeDir2 options =
  Encode.object
    [ ("showHidden", Encode.bool options.showHidden)
    , ("depth", Util.encodeDepth options.depth)
    , ("colors", Encode.bool options.colors)
    ]
