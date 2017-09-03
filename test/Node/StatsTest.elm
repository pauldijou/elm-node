module Node.StatsTest exposing (tests)

import Ordeal exposing (..)

import Node.Constants as Constants exposing (fileAccess, fileType)
import Node.FileSystem as FS
import Node.Stats as Stats exposing (Stats)
import Native.Node.Test.Helpers

import Node.Console as Console


accessReadWrite: Constants.FileAccess
accessReadWrite =
  Constants.allFileAccess [ fileAccess.read, fileAccess.write ]

accessReadWriteExecute: Constants.FileAccess
accessReadWriteExecute =
  Constants.allFileAccess [ fileAccess.read, fileAccess.write, fileAccess.execute ]

commonTest: Stats -> Expectation
commonTest stats =
  all
  [ Stats.uid stats |> shouldEqual Native.Node.Test.Helpers.uid
  , Stats.gid stats |> shouldEqual Native.Node.Test.Helpers.gid
  , Stats.birthtime stats |> shouldEqual Native.Node.Test.Helpers.birthtime
  , Stats.ctime stats |> shouldEqual Native.Node.Test.Helpers.ctime
  , Stats.mtime stats |> shouldEqual Native.Node.Test.Helpers.mtime
  , Stats.atime stats |> shouldEqual Native.Node.Test.Helpers.atime
  ]

isFile: Stats -> Expectation
isFile stats =
  all
  [ Stats.isFile stats |> shouldEqual True
  , Stats.isDirectory stats |> shouldEqual False
  , Stats.isBlockDevice stats |> shouldEqual False
  , Stats.isCharacterDevice stats |> shouldEqual False
  , Stats.isSymbolicLink stats |> shouldEqual False
  , Stats.isFIFO stats |> shouldEqual False
  , Stats.isSocket stats |> shouldEqual False
  , Stats.is fileType.file stats |> shouldEqual True
  , Stats.is fileType.directory stats |> shouldEqual False
  , Stats.is fileType.characterOrientedFile stats |> shouldEqual False
  , Stats.is fileType.blockOrientedFile stats |> shouldEqual False
  , Stats.is fileType.fifo stats |> shouldEqual False
  , Stats.is fileType.symlink stats |> shouldEqual False
  , Stats.is fileType.socket stats |> shouldEqual False
  ]

isDirectory: Stats -> Expectation
isDirectory stats =
  all
  [ Stats.isFile stats |> shouldEqual False
  , Stats.isDirectory stats |> shouldEqual True
  , Stats.isBlockDevice stats |> shouldEqual False
  , Stats.isCharacterDevice stats |> shouldEqual False
  , Stats.isSymbolicLink stats |> shouldEqual False
  , Stats.isFIFO stats |> shouldEqual False
  , Stats.isSocket stats |> shouldEqual False
  , Stats.is fileType.file stats |> shouldEqual False
  , Stats.is fileType.directory stats |> shouldEqual True
  , Stats.is fileType.characterOrientedFile stats |> shouldEqual False
  , Stats.is fileType.blockOrientedFile stats |> shouldEqual False
  , Stats.is fileType.fifo stats |> shouldEqual False
  , Stats.is fileType.symlink stats |> shouldEqual False
  , Stats.is fileType.socket stats |> shouldEqual False
  ]

isSymbolicLink: Stats -> Expectation
isSymbolicLink stats =
  all
  [ Stats.isFile stats |> shouldEqual False
  , Stats.isDirectory stats |> shouldEqual False
  , Stats.isBlockDevice stats |> shouldEqual False
  , Stats.isCharacterDevice stats |> shouldEqual False
  , Stats.isSymbolicLink stats |> shouldEqual True
  , Stats.isFIFO stats |> shouldEqual False
  , Stats.isSocket stats |> shouldEqual False
  , Stats.is fileType.file stats |> shouldEqual False
  , Stats.is fileType.directory stats |> shouldEqual False
  , Stats.is fileType.characterOrientedFile stats |> shouldEqual False
  , Stats.is fileType.blockOrientedFile stats |> shouldEqual False
  , Stats.is fileType.fifo stats |> shouldEqual False
  , Stats.is fileType.symlink stats |> shouldEqual True
  , Stats.is fileType.socket stats |> shouldEqual False
  ]

tests: Test
tests =
  describe "Stats"
    [ test "file" (
      FS.stat "file"
      |> shouldSucceedAnd (\stats ->
        all
        [ commonTest stats
        , isFile stats
        , Stats.size stats |> shouldEqual 7
        , Stats.toOctalPermissions stats |> shouldEqual "0666"
        ]
      )
    )
    , test "directory" (
      FS.stat "folder"
      |> shouldSucceedAnd (\stats ->
        all
        [ commonTest stats
        , isDirectory stats
        , Stats.toOctalPermissions stats |> shouldEqual "0777"
        ]
      )
    )
    , test "symlink" (
      FS.lstat "symlink"
      |> shouldSucceedAnd (\stats ->
        all
        [ commonTest stats
        , isSymbolicLink stats
        , Stats.toOctalPermissions stats |> shouldEqual "0666"
        ]
      )
    )
    , test "symlink (followed)" (
      FS.stat "symlink"
      |> shouldSucceedAnd (\stats ->
        all
        [ commonTest stats
        , isFile stats
        , Stats.size stats |> shouldEqual 7
        , Stats.toOctalPermissions stats |> shouldEqual "0666"
        ]
      )
    )
    ]
