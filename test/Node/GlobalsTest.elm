module Node.GlobalsTest exposing (tests)

import Ordeal exposing (..)

import Node.Globals as Globals
import Node.Path as Path

tests: Test
tests =
  describe "Globals"
    [ test "dirname" (
      Globals.filename |> shouldPass (String.contains "elm-node")
    )
    , test "filename" (
      Globals.filename |> shouldPass (String.endsWith ".test.js")
    )
    , test "is it all good?" (
      Path.dirname Globals.filename |> shouldEqual Globals.dirname
    )
    ]
