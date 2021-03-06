module Node.Internals exposing (..)

import Dict exposing (Dict)
import Json.Encode as Encode
import Node.Constants exposing (..)

encodeDepth: Depth -> Encode.Value
encodeDepth depth =
  case depth of
    Depth int -> Encode.int int
    Infinite  -> Encode.null

encodeEncoding: Encoding -> Encode.Value
encodeEncoding encoding =
  case encoding of
    Ascii   -> Encode.string "ascii"
    Utf8    -> Encode.string "utf8"
    Utf16le -> Encode.string "utf16le"
    Ucs2    -> Encode.string "ucs2"
    Base64  -> Encode.string "base64"
    Latin1  -> Encode.string "latin1"
    Binary  -> Encode.string "binary"
    Hex     -> Encode.string "hex"

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

encodeMaybe: (a -> Encode.Value) -> Maybe a -> Encode.Value
encodeMaybe encoder value =
  value |> Maybe.map encoder |> Maybe.withDefault Encode.null

encodeField: String -> Encode.Value -> (String, Encode.Value)
encodeField name value =
  (name, value)

encodeMaybeField: String -> (a -> Encode.Value) -> Maybe a -> Maybe (String, Encode.Value)
encodeMaybeField name encoder value =
  value |> Maybe.map (encoder >> (encodeField name))

encodeDict: (a -> Encode.Value) -> Dict String a -> Encode.Value
encodeDict encoder dict =
  dict
  |> Dict.map (\key value -> encoder value)
  |> Dict.toList
  |> Encode.object

encodeList: (a -> Encode.Value) -> List a -> Encode.Value
encodeList encoder list =
  Encode.list (List.map encoder list)
