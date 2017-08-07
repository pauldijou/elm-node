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
      |> and (Path.extname "index.html" |> shouldEqual ".html")
      |> and (Path.extname "index.coffee.md" |> shouldEqual ".md")
      |> and (Path.extname "index." |> shouldEqual ".")
      |> and (Path.extname "index" |> shouldEqual "")
      |> and (Path.extname ".index" |> shouldEqual "")
    )
    , test "format" (
      success
      |> and (
        Path.format
          { defaultFormatted
          | root = Just "/ignored"
          , dir = Just "/home/user/dir"
          , base = Just "file.txt"
          }
        |> shouldEqual "/home/user/dir/file.txt"
      )
      |> and (
        Path.format
          { defaultFormatted
          | root = Just "/"
          , base = Just "file.txt"
          , ext = Just "ignored"
          }
        |> shouldEqual "/file.txt"
      )
      |> and (
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
      |> and (Path.isAbsolute "/foo/bar" |> shouldEqual True)
      |> and (Path.isAbsolute "/baz/.." |> shouldEqual True)
      |> and (Path.isAbsolute "qux/" |> shouldEqual False)
      |> and (Path.isAbsolute "." |> shouldEqual False)
    )
    , test "join" (
      success
      |> and (Path.join ["/foo", "bar", "baz/asdf", "quux", ".."] |> shouldEqual "/foo/bar/baz/asdf")
      |> and (Path.join2 "/foo" "bar" |> shouldEqual "/foo/bar")
      |> and (Path.join3 "/foo" "bar" "baz/asdf" |> shouldEqual "/foo/bar/baz/asdf")
      |> and (Path.join4 "/foo" "bar" "baz/asdf" "quux" |> shouldEqual "/foo/bar/baz/asdf/quux")
      |> and (Path.join5 "/foo" "bar" "baz/asdf" "quux" ".." |> shouldEqual "/foo/bar/baz/asdf")
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
      |> and (Path.resolve ["/foo/bar", "./baz"] |> shouldEqual "/foo/bar/baz")
      |> and (Path.resolve ["/foo/bar", "/tmp/file/"] |> shouldEqual "/tmp/file")
      |> and (Path.resolve1 "/foo" |> shouldEqual "/foo")
      |> and (Path.resolve2 "/foo" "bar" |> shouldEqual "/foo/bar")
      |> and (Path.resolve3 "/foo" "bar" "baz/asdf" |> shouldEqual "/foo/bar/baz/asdf")
      |> and (Path.resolve4 "/foo" "bar" "baz/asdf" "quux" |> shouldEqual "/foo/bar/baz/asdf/quux")
      |> and (Path.resolve5 "/foo" "bar" "baz/asdf" "quux" ".." |> shouldEqual "/foo/bar/baz/asdf")
      |> and (
        Process.cwd
        |> Task.mapError (\_ -> "Never")
        |> andTest (shouldEqual <| Path.resolve1 ".")
      )
    )
    ]
