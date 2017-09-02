module Node.ConsoleTest exposing (tests)

import Ordeal exposing (..)

import Node.Console as Console
import Native.Node.Test.Helpers

value: { a: Int, b: String }
value =
  { a = 1, b = "b" }

tests: Test
tests =
  describe "Console"
    [ test "clear" (
      Console.clear 1 |> shouldEqual 1
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
    , test "dir" (Console.dir value |> shouldEqual value)
    , test "dir2" (Console.dir2 Console.defaultOptions value |> shouldEqual value)
    , test "error" (Console.error "error" |> shouldEqual "error")
    , test "info" (Console.info "info" |> shouldEqual "info")
    , test "log" (Console.log "log" |> shouldEqual "log")
    , test "time" (Console.time "time label" 1 |> shouldEqual 1)
    , test "timeEnd" (Console.timeEnd "time label" 1 |> shouldEqual 1)
    , test "trace" (Console.trace "trace" 1 |> shouldEqual 1)
    , test "warn" (Console.warn "warn" |> shouldEqual "warn")
    ]
