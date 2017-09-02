module Node.Internals exposing (..)

import Dict exposing (Dict)
import Json.Encode as Encode
import Node.Types exposing (..)

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
