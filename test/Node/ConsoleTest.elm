module Node.ConsoleTest exposing (tests)

import Ordeal exposing (..)

import Node.Process as Process
import Node.Console as Console exposing (defaultOptions)
import Native.Node.Test.Helpers

value: { a: Int, b: String, c: Bool }
value =
  { a = 123456789, b = "bbbbbb", c = True }

options: Console.Options
options =
  { defaultOptions | showHidden = True, colors = True }

tests: Test
tests =
  describe "Console"
    [ test "clear" (
      1 |> shouldEqual 1
      -- Console.clear 1 |> shouldEqual 1
    )
    , test "Node version" (
      let
        a = Console.log Process.version
      in
        1 |> shouldEqual 1
    )
    , test "count" (
      all
      [ Console.count Console.defaultLabel 1 |> shouldEqual 1
      , Console.count Console.defaultLabel 1 |> shouldEqual 1
      , Console.count "a" 1 |> shouldEqual 1
      , Console.count "b" 1 |> shouldEqual 1
      , Console.count "a" 1 |> shouldEqual 1
      , Console.count "b" 1 |> shouldEqual 1
      ]
    )
    , test "countReset" (
      all
      [ Console.countReset "a" 1 |> shouldEqual 1
      , Console.count "a" 1 |> shouldEqual 1
      , Console.countReset "a" 1 |> shouldEqual 1
      , Console.count "a" 1 |> shouldEqual 1
      , Console.countReset "b" 1 |> shouldEqual 1
      , Console.count "b" 1 |> shouldEqual 1
      ]
    )
    , test "dir" (Console.dir value |> shouldEqual value)
    , test "dir2" (Console.dir2 defaultOptions value |> shouldEqual value)
    , test "dir2" (Console.dir2 options value |> shouldEqual value)
    , test "error" (Console.error "error" |> shouldEqual "error")
    , test "info" (Console.info "info" |> shouldEqual "info")
    , test "log" (Console.log "log" |> shouldEqual "log")
    , test "time" (
      all
      [ Console.time "time label" 1 |> shouldEqual 1
      , Console.timeEnd "time label" 1 |> shouldEqual 1
      ]
    )
    , test "trace" (Console.trace "trace" 1 |> shouldEqual 1)
    , test "warn" (Console.warn "warn" |> shouldEqual "warn")
    ]
