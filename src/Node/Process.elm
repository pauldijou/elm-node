module Node.Process exposing
  ( CpuUsage
  , Hrtime
  , MemoryUsage
  , Release
  , Signal(SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGABRT, SIGFPE, SIGKILL, SIGSEGV, SIGPIPE, SIGALRM, SIGTERM, SIGUSR1, SIGUSR2, SIGCHLD, SIGCONT, SIGSTOP, SIGTSTP, SIGTTIN, SIGTTOU)
  , abort
  , arch
  , argv
  , argv0
  , chdir
  , config
  , connected
  , cpuUsage
  , cpuUsageSince
  , cwd
  , disconnect
  , env
  , execArgv
  , execPath
  , exit
  , hrtime
  , hrtimeSince
  , kill
  , killWith
  , memoryUsage
  , pid
  , platform
  , release
  , title
  , withTitle
  , uptime
  , version
  , versions
  )

{-| https://nodejs.org/docs/latest/api/process.html


# Types

@docs CpuUsage, Hrtime, MemoryUsage, Release, Signal

# Functions

@docs abort, arch, argv, argv0, chdir, config, connected, cpuUsage, cpuUsageSince, cwd, disconnect, env, execArgv, execPath, exit, hrtime, hrtimeSince, kill, killWith, memoryUsage, pid, platform, release, title, withTitle, uptime, version, versions

-}

import Task exposing (Task)
import Dict exposing (Dict)
import Json.Encode as Encode
import Json.Decode as Decode exposing (Decoder)

import Kernel.Helpers

import Native.Node.Process

{-| -}
type alias CpuUsage = { user: Int, system: Int }

{-| -}
type alias Hrtime = { seconds: Int, nanoseconds: Int }

{-| -}
type alias MemoryUsage = { rss: Int, heapTotal: Int, heapUsed: Int, external: Int }

{-| -}
type alias Release =
  { name: String
  , sourceUrl: String
  , headersUrl: String
  , libUrl: Maybe String
  , lts: Maybe String
  }

{-| -}
type Signal = SIGHUP | SIGINT | SIGQUIT | SIGILL | SIGABRT | SIGFPE | SIGKILL | SIGSEGV | SIGPIPE | SIGALRM | SIGTERM | SIGUSR1 | SIGUSR2 | SIGCHLD | SIGCONT | SIGSTOP | SIGTSTP | SIGTTIN | SIGTTOU

{-| -}
abort: Task Never ()
abort = Native.Node.Process.abort

{-| -}
arch: String
arch = Native.Node.Process.arch

{-| -}
argv: List String
argv = Native.Node.Process.argv

{-| -}
argv0: String
argv0 = Native.Node.Process.argv0

{-| -}
chdir: String -> Task String ()
chdir = Native.Node.Process.chdir

{-| -}
config: Encode.Value
config = Native.Node.Process.config

{-| -}
connected: Task Never Bool
connected = Native.Node.Process.connected

{-| -}
cpuUsage: Task Never CpuUsage
cpuUsage = Native.Node.Process.cpuUsage

{-| -}
cpuUsageSince: CpuUsage -> Task Never CpuUsage
cpuUsageSince = Native.Node.Process.cpuUsageSince

{-| -}
cwd: Task Never String
cwd = Native.Node.Process.cwd

{-| -}
disconnect: Task Never ()
disconnect = Native.Node.Process.disconnect

{-| -}
env: Dict String String
env =
  case Decode.decodeValue (Decode.dict Decode.string) Native.Node.Process.env of
    Ok dict -> dict
    Err _ -> Dict.empty

{-| -}
execArgv: List String
execArgv = Native.Node.Process.execArgv

{-| -}
execPath: String
execPath = Native.Node.Process.execPath

{-| -}
exit: Int -> Task Never ()
exit = Native.Node.Process.exit

{-| -}
hrtime: Task Never Hrtime
hrtime = Native.Node.Process.hrtime

{-| -}
hrtimeSince: Hrtime -> Task Never Hrtime
hrtimeSince = Native.Node.Process.hrtimeSince

{-| -}
kill: Int -> Task Never ()
kill = Native.Node.Process.kill

{-| -}
killWith: Signal -> Int -> Task Never ()
killWith signal code =
  Native.Node.Process.killWith (encodeSignal signal) code

{-| -}
memoryUsage: Task Never MemoryUsage
memoryUsage = Native.Node.Process.memoryUsage

{-| -}
pid: Int
pid = Native.Node.Process.pid

{-| -}
platform: String
platform = Native.Node.Process.platform

{-| -}
release: Release
release =
  case Decode.decodeValue decoderRelease Native.Node.Process.release of
    -- Normal use case
    Ok release -> release
    -- In custom builds from non-release versions of the source tree,
    -- only the name property may be present.
    Err _ ->
      let
        name =
          Decode.decodeValue (Decode.field "name" Decode.string) Native.Node.Process.release
          |> Result.withDefault ""
      in
        { name = name, sourceUrl = "", headersUrl = "", libUrl = Nothing, lts = Nothing }

{-| -}
title: Task Never String
title = Native.Node.Process.title

{-| -}
withTitle: String -> Task Never String
withTitle = Native.Node.Process.withTitle

{-| -}
uptime: Task Never Float
uptime = Native.Node.Process.uptime

{-| -}
version: String
version = Native.Node.Process.version

{-| -}
versions: Dict String String
versions =
  case Decode.decodeValue (Decode.dict Decode.string) Native.Node.Process.versions of
    Ok dict -> dict
    Err _ -> Dict.empty


-- -----------------------------------------------------------------------------
-- JSON

encodeSignal: Signal -> Encode.Value
encodeSignal sig =
  case sig of
  SIGHUP  -> Encode.string "SIGHUP"
  SIGINT  -> Encode.string "SIGINT"
  SIGQUIT -> Encode.string "SIGQUIT"
  SIGILL  -> Encode.string "SIGILL"
  SIGABRT -> Encode.string "SIGABRT"
  SIGFPE  -> Encode.string "SIGFPE"
  SIGKILL -> Encode.string "SIGKILL"
  SIGSEGV -> Encode.string "SIGSEGV"
  SIGPIPE -> Encode.string "SIGPIPE"
  SIGALRM -> Encode.string "SIGALRM"
  SIGTERM -> Encode.string "SIGTERM"
  SIGUSR1 -> Encode.string "SIGUSR1"
  SIGUSR2 -> Encode.string "SIGUSR2"
  SIGCHLD -> Encode.string "SIGCHLD"
  SIGCONT -> Encode.string "SIGCONT"
  SIGSTOP -> Encode.string "SIGSTOP"
  SIGTSTP -> Encode.string "SIGTSTP"
  SIGTTIN -> Encode.string "SIGTTIN"
  SIGTTOU -> Encode.string "SIGTTOU"

decoderRelease: Decoder Release
decoderRelease =
  Decode.map5 Release
    (Decode.field "name" Decode.string)
    (Decode.field "sourceUrl" Decode.string)
    (Decode.field "headersUrl" Decode.string)
    (Decode.maybe <| Decode.field "libUrl" Decode.string)
    (Decode.maybe <| Decode.field "lts" Decode.string)

noWarnings: String
noWarnings = Kernel.Helpers.removeWarnings
