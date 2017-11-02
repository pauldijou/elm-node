module Node.Globals exposing (dirname, filename)

{-|
Node API: https://nodejs.org/api/globals.html

Provide some global constants.

@docs dirname, filename
-}

import Native.Node.Globals

{-|
The directory name of the resulting compiled JavaScript file.
This the same as the Node.Path.dirname of the Node.Globals.filename.
-}
dirname: String
dirname =
  Native.Node.Globals.dirname

{-|
The file name of the resulting compiled JavaScript file.
-}
filename: String
filename =
  Native.Node.Globals.filename
