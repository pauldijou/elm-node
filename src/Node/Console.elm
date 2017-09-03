module Node.Console exposing
  ( Options
  , defaultOptions
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

@docs Options, defaultOptions, clear, defaultLabel, count, countReset, dir, dir2, error, info, log, time, timeEnd, trace, warn
-}

import Json.Encode as Encode
import Node.Types as Types
import Node.Util as Util
import Node.Internals as Internals
import Native.Node.Console

{-|
showHidden - if true then the object's non-enumerable and symbol properties will be shown too. Defaults to false.

depth - tells util.inspect() how many times to recurse while formatting the object. This is useful for inspecting large complicated objects. Defaults to 2. To make it recurse indefinitely, pass null.

colors - if true, then the output will be styled with ANSI color codes. Defaults to false. Colors are customizable; see customizing util.inspect() colors.
-}
type alias Options =
  { showHidden: Bool
  , depth: Types.Depth
  , colors: Bool
  }

{-| Default values for options -}
defaultOptions: Options
defaultOptions =
  { showHidden = False
  , depth = Types.Depth 2
  , colors = False
  }

{-|
When stdout is a TTY, calling console.clear() will attempt to clear the TTY. When stdout is not a TTY, this method does nothing.

Note: The specific operation of console.clear() can vary across operating systems and terminal types. For most Linux operating systems, console.clear() operates similarly to the clear shell command. On Windows, console.clear() will clear only the output in the current terminal viewport for the Node.js binary.
-}
clear: a -> a
clear =
  Native.Node.Console.clear

{-|
Maintains an internal counter specific to label and outputs to stdout the number of times console.count() has been called with the given label.

label `String` The display label for the counter. Defaults to 'default'.
-}
defaultLabel: String
defaultLabel = "default"

{-| -}
count: String -> a -> a
count =
  Native.Node.Console.count

{-|
Resets the internal counter specific to label.

label `String` The display label for the counter. Defaults to 'default'.
-}
countReset: String -> a -> a
countReset =
  Native.Node.Console.countReset

{-|
Uses util.inspect() on obj and prints the resulting string to stdout. This function bypasses any custom inspect() function defined on obj.
-}
dir: a -> a
dir =
  Native.Node.Console.dir

{-|
Uses util.inspect() on obj and prints the resulting string to stdout. This function bypasses any custom inspect() function defined on obj. An options object is passed to alter certain aspects of the formatted string.
-}
dir2: Options -> a -> a
dir2 options value =
  Native.Node.Console.dir2 (encodeOptions options) value

{-|
Prints to stderr with newline. Multiple arguments can be passed, with the first used as the primary message and all additional used as substitution values similar to printf(3) (the arguments are all passed to util.format()).
-}
error: a -> a
error =
  Native.Node.Console.error

{-|
The console.info() function is an alias for console.log().
-}
info: a -> a
info =
  Native.Node.Console.info

{-|
Prints to stdout with newline. Multiple arguments can be passed, with the first used as the primary message and all additional used as substitution values similar to printf(3) (the arguments are all passed to util.format()).
-}
log: a -> a
log =
  Native.Node.Console.log

{-|
Starts a timer that can be used to compute the duration of an operation. Timers are identified by a unique label. Use the same label when calling console.timeEnd() to stop the timer and output the elapsed time in milliseconds to stdout. Timer durations are accurate to the sub-millisecond.
-}
time: String -> a -> a
time =
  Native.Node.Console.time

{-|
Stops a timer that was previously started by calling console.time() and prints the result to stdout.
-}
timeEnd: String -> a -> a
timeEnd =
  Native.Node.Console.timeEnd

{-|
Prints to stderr the string 'Trace :', followed by the util.format() formatted message and stack trace to the current position in the code.
-}
trace: String -> a -> a
trace =
  Native.Node.Console.trace

{-|
The console.warn() function is an alias for console.error().
-}
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
