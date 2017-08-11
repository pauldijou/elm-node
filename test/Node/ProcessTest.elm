module Node.ProcessTest exposing (tests)

import Dict exposing (Dict)
import Task exposing (Task)
import Process as ElmProcess
import Json.Decode as Decode

import Ordeal exposing (..)

import Node.ExitCodes as ExitCodes
import Node.Path as Path
import Node.Util as Util
import Node.Process as Process
import Native.Node.Test.Helpers


currentDir: String
currentDir = Path.resolve [ "." ]

parentDir: String
parentDir = Path.resolve [ ".." ]

wrapNever: Task Never a -> Task String a
wrapNever = Task.mapError (\_ -> "Never")

tests: Test
tests =
  describe "Process"
    [ test "arch" (
      Process.arch |> shouldBeOneOf [ "arm", "ia32", "x64" ]
    )
    , test "argv" (
      Process.argv
      |> List.indexedMap (\index value ->
        if (index == 0)
        then String.endsWith "node" value
        else if (index == 1)
        then String.endsWith "elm-ordeal" value
        else if (index == 2)
        then value == "test/NodeTest.elm"
        else True
      )
      |> List.all identity
      |> shouldEqual True
    )
    , test "argv0" (
      Process.argv0 |> shouldEqual "node"
    )
    , test "chdir" (
      Process.chdir parentDir
      |> Task.andThen (\_ -> Process.cwd |> wrapNever)
      |> shouldSucceedWith parentDir
      |> and (
        Process.chdir currentDir
        |> Task.andThen (\_ -> Process.cwd |> wrapNever)
        |> shouldSucceedWith currentDir
      )
    )
    , test "config" (
      case Decode.decodeValue (Decode.at [ "variables", "host_arch" ] Decode.string) Process.config of
        Ok arch -> arch |> shouldEqual Process.arch
        Err err -> failure err
    )
    , test "connected" (
      Process.connected
      |> shouldSucceedWith False
    )
    , test "cpuUsage" (
      Process.cpuUsage
      |> andTest (\usage ->
        if (usage.user > 0 && usage.system > 0)
        then success
        else failure "CPU usages should be positive"
      )
    )
    , test "cpuUsageSince" (
      Process.cpuUsage
      |> Task.andThen (\usage ->
        ElmProcess.sleep 5
        |> Task.map (\_ -> usage)
      )
      |> Task.andThen Process.cpuUsageSince
      |> andTest (\usage ->
        if ((usage.user == 0 || usage.user == 4000)  && usage.system == 0)
        then success
        else failure <| "CPU usages should be zero but is:" ++ (toString usage)
      )
    )
    , test "cwd" (
      Process.cwd |> wrapNever |> shouldSucceedWith currentDir
    )
    , test "env" (
      success
      |> and (Process.env |> Dict.get "USER" |> shouldBeJust)
      |> and (Process.env |> Dict.get "LANGUAGE" |> shouldBeJust)
      |> and (Process.env |> Dict.get "npm_package_scripts_test" |> shouldBeJust)
      |> and (Process.env |> Dict.get "npm_lifecycle_event" |> shouldEqual (Just "test"))
    )
    , test "execArgv" (
      Process.execArgv |> shouldEqual []
    )
    , test "execPath" (
      Process.execPath |> String.endsWith "node" |> shouldEqual True
    )
    , test "hrtime" (
      Process.hrtime
      |> andTest (\time ->
        if time.seconds > 1000 && time.nanoseconds > 0
        then success
        else failure <| "Wrong time: " ++ (toString time)
      )
    )
    , test "hrtimeSince" (
      Process.hrtime
      |> Task.andThen (\time ->
        ElmProcess.sleep 1
        |> Task.map (\_ -> time)
      )
      |> Task.andThen Process.hrtimeSince
      |> wrapNever
      |> andTest (\time ->
        if (time.seconds == 0  && time.nanoseconds > 1000000)
        then success
        else failure <| "Should be a really small time:" ++ (toString time)
      )
    )
    , test "memoryUsage" (
      Process.memoryUsage
      |> wrapNever
      |> andTest (\usage ->
        if (  usage.rss       > 10000000
           && usage.heapTotal > 10000000
           && usage.heapUsed  > 10000000
           && usage.external  > 10000
           )
        then success
        else failure <| "Wrong memory usage: " ++ (toString usage)
      )
    )
    , test "pid" (
      Process.pid |> shouldBeGreaterThan 0
    )
    , test "platform" (
      Process.platform |> shouldBeOneOf [ "darwin", "freebsd", "linux", "sunos", "win32" ]
    )
    , test "release" (
      let
        release = Process.release
      in
        success
        |> and (release.name |> shouldEqual "node")
        |> and (release.sourceUrl |> shouldPass (\v -> String.length v > 0))
        |> and (release.headersUrl |> shouldPass (\v -> String.length v > 0))

    )
    , test "title" (
      Process.title
      |> wrapNever
      |> andTest (shouldEqual "elm-ordeal")
    )
    , test "withTitle" (
      Process.withTitle "elm-node"
      |> wrapNever
      |> shouldSucceed
      |> and (
        Process.title
        |> wrapNever
        |> andTest (shouldEqual "elm-node")
      )
    )
    , test "uptime" (
      Process.uptime
      |> wrapNever
      |> andTest (shouldBeGreaterThan 0)
    )
    , test "version" (
      Process.version |> shouldPass (\v -> String.length v > 0)
    )
    , test "versions" (
      Process.versions |> shouldNotEqual Dict.empty
      |> and (Process.versions |> Dict.get "modules" |> shouldBeJust)
    )
    ]
