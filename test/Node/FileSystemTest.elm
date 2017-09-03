module Node.FileSystemTest exposing (tests)

import Ordeal exposing (..)

import Node.Constants as Constants exposing (fileAccess)
import Node.FileSystem as FS
import Node.Stats as Stats
import Native.Node.Test.Helpers


accessReadWrite: Constants.FileAccess
accessReadWrite =
  Constants.allFileAccess [ fileAccess.read, fileAccess.write ]

accessReadWriteExecute: Constants.FileAccess
accessReadWriteExecute =
  Constants.allFileAccess [ fileAccess.read, fileAccess.write, fileAccess.execute ]

tests: Test
tests =
  describe "FileSystem"
    [ test "access" (
      all
      [ FS.access "./azeqsdwxc" fileAccess.visible |> shouldFail
      , FS.accessSync "./azeqsdwxc" fileAccess.visible |> shouldBeErr
      , FS.access "file" fileAccess.visible |> shouldSucceed
      , FS.accessSync "file" fileAccess.visible |> shouldBeOk
      , FS.accessSync "file" fileAccess.read |> shouldBeOk
      , FS.accessSync "file" fileAccess.write |> shouldBeOk
      , FS.accessSync "file" fileAccess.execute |> shouldBeErr
      , FS.accessSync "file" accessReadWrite |> shouldBeOk
      , FS.accessSync "file" accessReadWriteExecute |> shouldBeErr
      ]
    )
    ]
