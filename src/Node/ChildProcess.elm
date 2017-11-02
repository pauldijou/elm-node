module Node.ChildProcess exposing
  ( Id
  , Stdio(..)
  , OptionsExec
  , optionsExec
  , exec
  , OptionsExecFile
  , optionsExecFile
  , execFile
  )

{-|
Node API: https://nodejs.org/api/child_process.html

The child_process module provides the ability to spawn child processes in a manner that is similar, but not identical, to popen(3). This capability is primarily provided by the child_process.spawn() function.

@docs Id, Stdio

@docs exec, OptionsExec, optionsExec

@docs execFile, OptionsExecFile, optionsExecFile
-}

import Dict exposing (Dict)
import Task exposing (Task)
import Json.Encode as Encode
import Error exposing (Error)
import Kernel.Helpers

import Node.Constants exposing (Encoding, Signal)
import Node.Internals as I
import Native.Node.ChildProcess


{-| -}
type alias Id = String

{-| -}
type Stdio = Default | Pipe | Ipc | Ignore | Stdin | Stdout | Stderr



{-| -}
type alias OptionsExec =
  { cwd: Maybe String
  , env: Dict String String
  , encoding: Maybe Encoding
  , shell: Maybe String
  , timeout: Maybe Float
  , maxBuffer: Maybe Int
  , killSignal: Maybe Signal
  , uid: Maybe Int
  , gid: Maybe Int
  , windowsHide: Maybe Bool
  }

{-| -}
optionsExec: OptionsExec
optionsExec =
  { cwd = Nothing
  , env = Dict.empty
  , encoding = Nothing
  , shell = Nothing
  , timeout = Nothing
  , maxBuffer = Nothing
  , killSignal = Nothing
  , uid = Nothing
  , gid = Nothing
  , windowsHide = Nothing
  }

{-| -}
exec: String -> OptionsExec -> Task Error { stdout: String, stderr: String }
exec cmd options =
  Native.Node.ChildProcess.exec cmd (encodeOptionsExec options)



{-| -}
type alias OptionsExecFile =
  { cwd: Maybe String
  , env: Dict String String
  , encoding: Maybe Encoding
  , timeout: Maybe Float
  , maxBuffer: Maybe Int
  , killSignal: Maybe Signal
  , uid: Maybe Int
  , gid: Maybe Int
  , windowsHide: Maybe Bool
  }

{-| -}
optionsExecFile: OptionsExecFile
optionsExecFile =
  { cwd = Nothing
  , env = Dict.empty
  , encoding = Nothing
  , timeout = Nothing
  , maxBuffer = Nothing
  , killSignal = Nothing
  , uid = Nothing
  , gid = Nothing
  , windowsHide = Nothing
  }

{-| -}
execFile: String -> List String -> OptionsExecFile -> Task Error { stdout: String, stderr: String }
execFile cmd args options =
  Native.Node.ChildProcess.execFile cmd (I.encodeList Encode.string args) (encodeOptionsExecFile options)



{-| -}
type alias OptionsFork =
  { cwd: Maybe String
  , env: Dict String String
  , execPath: Maybe String
  , execArgv: List String
  , silent: Maybe Bool
  , stdio: Maybe { stdin: Stdio, stdout: Stdio, stderr: Stdio }
  , uid: Maybe Int
  , gid: Maybe Int
  }

optionsFork: OptionsFork
optionsFork =
  { cwd = Nothing
  , env = Dict.empty
  , execPath = Nothing
  , execArgv = []
  , silent = Nothing
  , stdio = Nothing
  , uid = Nothing
  , gid = Nothing
  }


type Msg
  = Close      { id: Id, code: Int, signal: String }
  | Disconnect { id: Id }
  | Error      { id: Id, error: Error }
  | Exit       { id: Id, code: Int, signal: String }
  | Message    { id: Id, message: Encode.Value }

noWarnings: String
noWarnings =
  Kernel.Helpers.noWarnings

encodeOptionsExec: OptionsExec -> Encode.Value
encodeOptionsExec options =
  [ I.encodeMaybeField "cwd" Encode.string options.cwd
  , if Dict.isEmpty options.env
    then Nothing
    else Just ("env", I.encodeDict Encode.string options.env)
  , I.encodeMaybeField "encoding" I.encodeEncoding options.encoding
  , I.encodeMaybeField "shell" Encode.string options.shell
  , I.encodeMaybeField "timeout" Encode.float options.timeout
  , I.encodeMaybeField "maxBuffer" Encode.int options.maxBuffer
  , I.encodeMaybeField "killSignal" I.encodeSignal options.killSignal
  , I.encodeMaybeField "uid" Encode.int options.uid
  , I.encodeMaybeField "gid" Encode.int options.gid
  , I.encodeMaybeField "windowsHide" Encode.bool options.windowsHide
  ]
  |> List.filterMap identity
  |> Encode.object

encodeOptionsExecFile: OptionsExecFile -> Encode.Value
encodeOptionsExecFile options =
  [ I.encodeMaybeField "cwd" Encode.string options.cwd
  , if Dict.isEmpty options.env
    then Nothing
    else Just ("env", I.encodeDict Encode.string options.env)
  , I.encodeMaybeField "encoding" I.encodeEncoding options.encoding
  , I.encodeMaybeField "timeout" Encode.float options.timeout
  , I.encodeMaybeField "maxBuffer" Encode.int options.maxBuffer
  , I.encodeMaybeField "killSignal" I.encodeSignal options.killSignal
  , I.encodeMaybeField "uid" Encode.int options.uid
  , I.encodeMaybeField "gid" Encode.int options.gid
  , I.encodeMaybeField "windowsHide" Encode.bool options.windowsHide
  ]
  |> List.filterMap identity
  |> Encode.object

encodeStdio: Stdio -> Encode.Value
encodeStdio stdio =
  case stdio of
    Default -> Encode.null
    Pipe    -> Encode.string "pipe"
    Ipc     -> Encode.string "ipc"
    Ignore  -> Encode.string "ignore"
    Stdin   -> Encode.int 0
    Stdout  -> Encode.int 1
    Stderr  -> Encode.int 2

encodeFullStdio: { stdin: Stdio, stdout: Stdio, stderr: Stdio } -> Encode.Value
encodeFullStdio params =
  Encode.list
  [ encodeStdio params.stdin
  , encodeStdio params.stdout
  , encodeStdio params.stderr
  ]

encodeOptionsFork: OptionsFork -> Encode.Value
encodeOptionsFork options =
  [ I.encodeMaybeField "cwd" Encode.string options.cwd
  , if Dict.isEmpty options.env
    then Nothing
    else Just ("env", I.encodeDict Encode.string options.env)
  , I.encodeMaybeField "execPath" Encode.string options.execPath
  , if List.isEmpty options.execArgv
    then Nothing
    else Just ("execArgv", I.encodeList Encode.string options.execArgv)
  , I.encodeMaybeField "silent" Encode.bool options.silent
  , I.encodeMaybeField "stdio" encodeFullStdio options.stdio
  , I.encodeMaybeField "uid" Encode.int options.uid
  , I.encodeMaybeField "gid" Encode.int options.gid
  ]
  |> List.filterMap identity
  |> Encode.object
