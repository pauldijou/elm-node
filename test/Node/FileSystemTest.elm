module Node.FileSystemTest exposing (tests)

import Ordeal exposing (..)

import Node.FileSystem as FS exposing (constants)
import Native.Node.Test.Helpers

tests: Test
tests =
  describe "FileSystem"
    [ test "access" (
      FS.access "./azeqsdwxc" constants.access.visible
      |> shouldFail
    )
    ,  test "accessSync" (
      FS.accessSync "./azeqsdwxc" constants.access.visible
      |> shouldBeErr
    )
    ]
