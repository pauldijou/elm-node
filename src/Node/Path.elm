module Node.Path exposing
  ( Formatted
  , Parsed
  , defaultFormatted
  , basename
  , basenameExt
  , delimiter
  , dirname
  , extname
  , format
  , isAbsolute
  , join
  , normalize
  , parse
  , relative
  , relativeTo
  , resolve
  , sep
  , join2
  , join3
  , join4
  , join5
  , resolve1
  , resolve2
  , resolve3
  , resolve4
  , resolve5
  )

{-|
Node API: https://nodejs.org/docs/latest/api/path.html

The path module provides utilities for working with file and directory paths.

@docs Formatted, defaultFormatted, Parsed, basename, basenameExt, delimiter, dirname, extname, format, isAbsolute, join, normalize, parse, relative, relativeTo, resolve, sep, join2, join3, join4, join5, resolve1, resolve2, resolve3, resolve4, resolve5
-}

import Json.Encode as Encode
import Json.Decode as Decode exposing (Decoder)

import Node.Internals exposing (encodeMaybeField, encodeList)
import Native.Node.Path

{-| -}
type alias Formatted =
  { dir: Maybe String
  , root: Maybe String
  , base: Maybe String
  , name: Maybe String
  , ext: Maybe String
  }

{-| -}
defaultFormatted: Formatted
defaultFormatted =
  { dir = Nothing
  , root = Nothing
  , base = Nothing
  , name = Nothing
  , ext = Nothing
  }

{-| -}
type alias Parsed =
  { dir: String
  , root: String
  , base: String
  , name: String
  , ext: String
  }

{-| -}
basename: String -> String
basename = Native.Node.Path.basename

{-| Unlike the Node API, the first argument is the extension and the 2nd one is the file name -}
basenameExt: String -> String -> String
basenameExt = Native.Node.Path.basenameExt

{-| -}
delimiter: String
delimiter = Native.Node.Path.delimiter

{-| -}
dirname: String -> String
dirname = Native.Node.Path.dirname

{-| -}
extname: String -> String
extname = Native.Node.Path.extname

{-| -}
format: Formatted -> String
format options = Native.Node.Path.format (encodeFormatted options)

{-| -}
isAbsolute: String -> Bool
isAbsolute = Native.Node.Path.isAbsolute

{-| -}
join: List String -> String
join paths =
  Native.Node.Path.join (encodeList Encode.string paths)

{-| -}
normalize: String -> String
normalize = Native.Node.Path.normalize

{-| -}
parse: String -> Parsed
parse = Native.Node.Path.parse

{-| -}
relative: String -> String -> String
relative = Native.Node.Path.relative

{-| -}
relativeTo: String -> String -> String
relativeTo = flip relative

{-| -}
resolve: List String -> String
resolve paths =
  Native.Node.Path.resolve (encodeList Encode.string paths)

{-| -}
sep: String
sep = Native.Node.Path.sep



{-| -}
join2: String -> String -> String
join2 p1 p2 = join [p1, p2]

{-| -}
join3: String -> String -> String -> String
join3 p1 p2 p3 = join [p1, p2, p3]

{-| -}
join4: String -> String -> String -> String -> String
join4 p1 p2 p3 p4 = join [p1, p2, p3, p4]

{-| -}
join5: String -> String -> String -> String -> String -> String
join5 p1 p2 p3 p4 p5 = join [p1, p2, p3, p4, p5]

{-| -}
resolve1: String -> String
resolve1 p1 = resolve [p1]

{-| -}
resolve2: String -> String -> String
resolve2 p1 p2 = resolve [p1, p2]

{-| -}
resolve3: String -> String -> String -> String
resolve3 p1 p2 p3 = resolve [p1, p2, p3]

{-| -}
resolve4: String -> String -> String -> String -> String
resolve4 p1 p2 p3 p4 = resolve [p1, p2, p3, p4]

{-| -}
resolve5: String -> String -> String -> String -> String -> String
resolve5 p1 p2 p3 p4 p5 = resolve [p1, p2, p3, p4, p5]


-- -----------------------------------------------------------------------------
-- JSON

encodeFormatted: Formatted -> Encode.Value
encodeFormatted formatObject =
  [ encodeMaybeField "dir" Encode.string formatObject.dir
  , encodeMaybeField "root" Encode.string formatObject.root
  , encodeMaybeField "base" Encode.string formatObject.base
  , encodeMaybeField "name" Encode.string formatObject.name
  , encodeMaybeField "ext" Encode.string formatObject.ext
  ]
  |> List.filterMap identity
  |> Encode.object
