module Node.Internals exposing (..)

import Json.Encode as Encode
import Node.Encoding exposing (Encoding(..))

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
