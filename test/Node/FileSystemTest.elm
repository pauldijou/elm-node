module Node.FileSystemTest exposing (tests)

import Ordeal exposing (..)

import Node.FileSystem as FS exposing (constants)
import Node.Stats as Stats
import Native.Node.Test.Helpers

tests: Test
tests =
  describe "FileSystem"
    [ test "access" (
      all
      [ FS.access "./azeqsdwxc" constants.access.visible |> shouldFail
      , FS.accessSync "./azeqsdwxc" constants.access.visible |> shouldBeErr
      , FS.access "./package.json" constants.access.visible |> shouldSucceed
      , FS.accessSync "./package.json" constants.access.visible |> shouldBeOk
      ]
    )
    , test "stat" (
      FS.stat "./package.json"
      |> shouldSucceedAnd (\stats ->
        all
        [ Stats.isFile stats |> shouldEqual True
        , Stats.isDirectory stats |> shouldEqual False
        , Stats.isBlockDevice stats |> shouldEqual False
        , Stats.isCharacterDevice stats |> shouldEqual False
        , Stats.isSymbolicLink stats |> shouldEqual False
        , Stats.isFIFO stats |> shouldEqual False
        , Stats.isSocket stats |> shouldEqual False
        , Stats.size stats |> shouldBeGreaterThan 100
        ]
      )
    )
    ]
