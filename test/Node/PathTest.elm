module Node.PathTest exposing (all)

import Task

import Ordeal exposing (..)

import Node.Path as Path
import Node.Process as Process

defaultFormatted: Path.Formatted
defaultFormatted = Path.defaultFormatted

all: Test
all =
  describe "Path"
    [ test "basename" (
      Path.basename "/foo/bar/baz/asdf/quux.html" |> shouldEqual "quux.html"
    )
    , test "basenameExt" (
      Path.basenameExt ".html" "/foo/bar/baz/asdf/quux.html" |> shouldEqual "quux"
    )
    -- test "delimiter" ?? OS specific
    , test "dirname" (
      Path.dirname "/foo/bar/baz/asdf/quux" |> shouldEqual "/foo/bar/baz/asdf"
    )
    , test "extname" (
      success
      |> andThen (Path.extname "index.html" |> shouldEqual ".html")
      |> andThen (Path.extname "index.coffee.md" |> shouldEqual ".md")
      |> andThen (Path.extname "index." |> shouldEqual ".")
      |> andThen (Path.extname "index" |> shouldEqual "")
      |> andThen (Path.extname ".index" |> shouldEqual "")
    )
    , test "format" (
      success
      |> andThen (
        Path.format
          { defaultFormatted
          | root = Just "/ignored"
          , dir = Just "/home/user/dir"
          , base = Just "file.txt"
          }
        |> shouldEqual "/home/user/dir/file.txt"
      )
      |> andThen (
        Path.format
          { defaultFormatted
          | root = Just "/"
          , base = Just "file.txt"
          , ext = Just "ignored"
          }
        |> shouldEqual "/file.txt"
      )
      |> andThen (
        Path.format
          { defaultFormatted
          | root = Just "/"
          , name = Just "file"
          , ext = Just ".txt"
          }
        |> shouldEqual "/file.txt"
      )
    )
    , test "isAbsolute" (
      success
      |> andThen (Path.isAbsolute "/foo/bar" |> shouldEqual True)
      |> andThen (Path.isAbsolute "/baz/.." |> shouldEqual True)
      |> andThen (Path.isAbsolute "qux/" |> shouldEqual False)
      |> andThen (Path.isAbsolute "." |> shouldEqual False)
    )
    , test "join" (
      success
      |> andThen (Path.join ["/foo", "bar", "baz/asdf", "quux", ".."] |> shouldEqual "/foo/bar/baz/asdf")
      |> andThen (Path.join2 "/foo" "bar" |> shouldEqual "/foo/bar")
      |> andThen (Path.join3 "/foo" "bar" "baz/asdf" |> shouldEqual "/foo/bar/baz/asdf")
      |> andThen (Path.join4 "/foo" "bar" "baz/asdf" "quux" |> shouldEqual "/foo/bar/baz/asdf/quux")
      |> andThen (Path.join5 "/foo" "bar" "baz/asdf" "quux" ".." |> shouldEqual "/foo/bar/baz/asdf")
    )
    , test "normalize" (
      Path.normalize "/foo/bar//baz/asdf/quux/.." |> shouldEqual "/foo/bar/baz/asdf"
    )
    , test "parse" (
      Path.parse "/home/user/dir/file.txt"
      |> shouldEqual { root = "/", dir = "/home/user/dir", base = "file.txt", ext = ".txt", name = "file" }
    )
    , test "relative" (
      Path.relative "/data/orandea/test/aaa" "/data/orandea/impl/bbb"
      |> shouldEqual "../../impl/bbb"
    )
    , test "relativeTo" (
      "/data/orandea/test/aaa"
      |> Path.relativeTo "/data/orandea/impl/bbb"
      |> shouldEqual "../../impl/bbb"
    )
    , test "resolve" (
      success
      |> andThen (Path.resolve ["/foo/bar", "./baz"] |> shouldEqual "/foo/bar/baz")
      |> andThen (Path.resolve ["/foo/bar", "/tmp/file/"] |> shouldEqual "/tmp/file")
      |> andThen (Path.resolve1 "/foo" |> shouldEqual "/foo")
      |> andThen (Path.resolve2 "/foo" "bar" |> shouldEqual "/foo/bar")
      |> andThen (Path.resolve3 "/foo" "bar" "baz/asdf" |> shouldEqual "/foo/bar/baz/asdf")
      |> andThen (Path.resolve4 "/foo" "bar" "baz/asdf" "quux" |> shouldEqual "/foo/bar/baz/asdf/quux")
      |> andThen (Path.resolve5 "/foo" "bar" "baz/asdf" "quux" ".." |> shouldEqual "/foo/bar/baz/asdf")
      |> andThen (
        Process.cwd
        |> Task.mapError (\_ -> "Never")
        |> andTest (shouldEqual <| Path.resolve1 ".")
      )
    )
    ]
