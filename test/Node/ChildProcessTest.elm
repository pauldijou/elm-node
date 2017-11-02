module Node.ChildProcessTest exposing (tests)

import Ordeal exposing (..)

import Node.ChildProcess as ChildProcess
import Node.Path as Path

tests: Test
tests =
  describe "ChildProcess"
    [ test "exec version" (
      ChildProcess.exec "node --version" ChildProcess.optionsExec
      |> shouldSucceedAnd (\{ stdout, stderr } ->
        all
        [ stderr |> shouldEqual ""
        , String.length stdout |> shouldBeGreaterThan 4
        ]
      )
    )
    , test "exec error" (
      ChildProcess.exec "node -aze" ChildProcess.optionsExec
      |> shouldFail
    )
    , test "execFile version" (
      ChildProcess.execFile "node" ["--version"] ChildProcess.optionsExecFile
      |> shouldSucceedAnd (\{ stdout, stderr } ->
        all
        [ stderr |> shouldEqual ""
        , String.length stdout |> shouldBeGreaterThan 4
        ]
      )
    )
    , test "exec error" (
      ChildProcess.execFile "node" ["-aze"] ChildProcess.optionsExecFile
      |> shouldFail
    )
    ]
