module Node.Buffer exposing
  ( Buffer
  , Fill(..)
  , alloc
  , alloc2
  , alloc3
  , allocUnsafe
  , allocUnsafeSlow
  , byteLength
  , byteLength2
  , byteLengthBuffer
  , byteLengthBuffer2
  , compare
  , compareRange
  , concat
  , concat2
  , fromBuffer
  , fromString
  , isEncoding
  , poolSize
  , setPoolSize
  , copy
  , copyTo
  , equals
  , fill
  , fill2
  , fill3
  , fill4
  , includes
  , includes2
  , includes3
  , indexOf
  , indexOf2
  , indexOf3
  , lastIndexOf
  , lastIndexOf2
  , lastIndexOf3
  , length
  , slice
  , slice2
  , slice3
  , toJSON
  , stringify
  , stringify2
  , stringify3
  , stringify4
  , transcode
  , maxLength
  , maxStringLength
  , inspectMaxBytes
  )

{-|
Node API: https://nodejs.org/api/buffer.html

@docs Buffer, Fill

@docs alloc, alloc2, alloc3, allocUnsafe, allocUnsafeSlow, byteLength, byteLength2, byteLengthBuffer, byteLengthBuffer2, compare, compareRange, concat, concat2, fromBuffer, fromString, isEncoding, poolSize, setPoolSize, copy, copyTo, equals, fill, fill2, fill3, fill4, includes, includes2, includes3, indexOf, indexOf2, indexOf3, lastIndexOf, lastIndexOf2, lastIndexOf3, length, slice, slice2, slice3, toJSON, stringify, stringify2, stringify3, stringify4, transcode

@docs maxLength, maxStringLength, inspectMaxBytes
-}

import Task exposing (Task)
import Json.Encode as Encode

import Node.Encoding exposing (Encoding, defaultEncoding)
import Node.Internals exposing (encodeEncoding)
import Native.Node.Buffer

{-| -}
type Buffer = Buffer

{-| -}
type Fill = FillString String | FillInt Int | FillBuffer Buffer

encodedDefaultEncoding: Encode.Value
encodedDefaultEncoding = encodeEncoding defaultEncoding


{-| -}
alloc: Int -> Buffer
alloc size =
  Native.Node.Buffer.alloc size 0 encodedDefaultEncoding

{-| -}
alloc2: Int -> Fill -> Buffer
alloc2 size fill =
  Native.Node.Buffer.alloc size (encodeFill fill) encodedDefaultEncoding

{-| -}
alloc3: Int -> Fill -> Encoding -> Buffer
alloc3 size fill encoding =
  Native.Node.Buffer.alloc size (encodeFill fill) (encodeEncoding encoding)

{-| -}
allocUnsafe: Int -> Buffer
allocUnsafe =
  Native.Node.Buffer.allocUnsafe

{-| -}
allocUnsafeSlow: Int -> Buffer
allocUnsafeSlow =
  Native.Node.Buffer.allocUnsafe

{-| -}
byteLength: String -> Int
byteLength str =
  Native.Node.Buffer.byteLength str encodedDefaultEncoding

{-| -}
byteLength2: String -> Encoding -> Int
byteLength2 str encoding =
  Native.Node.Buffer.byteLength str (encodeEncoding encoding)

{-| -}
byteLengthBuffer: Buffer -> Int
byteLengthBuffer buffer =
  Native.Node.Buffer.byteLength buffer encodedDefaultEncoding

{-| -}
byteLengthBuffer2: Buffer -> Encoding -> Int
byteLengthBuffer2 buffer encoding =
  Native.Node.Buffer.byteLength buffer (encodeEncoding encoding)

{-| -}
compare: Buffer -> Buffer -> Order
compare b1 b2 =
  case Native.Node.Buffer.compare of
    -1 -> LT
    0 -> EQ
    _ -> GT

{-| -}
compareRange: { buffer: Buffer, start: Int, end: Int} -> { buffer: Buffer, start: Int, end: Int } -> Order
compareRange v1 v2 =
  case Native.Node.Buffer.compareRange v1 v2 of
    -1 -> LT
    0 -> EQ
    _ -> GT

{-| -}
concat: List Buffer -> Buffer
concat =
  Native.Node.Buffer.concat

{-| -}
concat2: List Buffer -> Int -> Buffer
concat2 =
  Native.Node.Buffer.concat2

{-| -}
fromBuffer: Buffer -> Buffer
fromBuffer =
  Native.Node.Buffer.fromBuffer

{-| -}
fromString: String -> Encoding -> Buffer
fromString str encoding =
  Native.Node.Buffer.fromString str (encodeEncoding encoding)

{-| -}
isEncoding: Encoding -> Buffer -> Bool
isEncoding encoding buffer =
  Native.Node.Buffer.isEncoding (encodeEncoding encoding) buffer

{-| -}
poolSize: Task Never Int
poolSize =
  Native.Node.Buffer.poolSize

{-| -}
setPoolSize: Int -> Task Never Int
setPoolSize =
  Native.Node.Buffer.setPoolSize

{-| -}
copy: { source: Buffer, target: Buffer, sourceStart: Int, sourceEnd: Int, targetStart: Int } -> Buffer
copy =
  Native.Node.Buffer.copy

{-| -}
copyTo: Buffer -> Buffer -> Buffer
copyTo =
  Native.Node.Buffer.copyTo

{-| -}
equals: Buffer -> Buffer -> Bool
equals =
  Native.Node.Buffer.equals

{-| -}
fill: Fill -> Buffer -> Buffer
fill value buffer =
  Native.Node.Buffer.fill (encodeFill value) buffer

{-| -}
fill2: Fill -> Int -> Buffer -> Buffer
fill2 value offset buffer =
  Native.Node.Buffer.fill2 (encodeFill value) offset buffer

{-| -}
fill3: Fill -> Int -> Int -> Buffer -> Buffer
fill3 value offset end buffer =
  Native.Node.Buffer.fill3 (encodeFill value) offset end buffer

{-| -}
fill4: Fill -> Int -> Int -> Encoding -> Buffer -> Buffer
fill4 value offset end encoding buffer =
  Native.Node.Buffer.fill4 (encodeFill value) offset end (encodeEncoding encoding) buffer

{-| -}
includes: Fill -> Buffer -> Bool
includes value buffer =
  Native.Node.Buffer.includes (encodeFill value) buffer

{-| -}
includes2: Fill -> Int -> Buffer -> Bool
includes2 value byteOffset buffer =
  Native.Node.Buffer.includes2 (encodeFill value) byteOffset buffer

{-| -}
includes3: Fill -> Int -> Encoding -> Buffer -> Bool
includes3 value byteOffset encoding buffer =
  Native.Node.Buffer.includes3 (encodeFill value) byteOffset (encodeEncoding encoding) buffer

{-| -}
indexOf: Fill -> Buffer -> Int
indexOf value buffer =
  Native.Node.Buffer.indexOf (encodeFill value) buffer

{-| -}
indexOf2: Fill -> Int -> Buffer -> Int
indexOf2 value byteOffset buffer =
  Native.Node.Buffer.indexOf2 (encodeFill value) byteOffset buffer

{-| -}
indexOf3: Fill -> Int -> Encoding -> Buffer -> Int
indexOf3 value byteOffset encoding buffer =
  Native.Node.Buffer.indexOf3 (encodeFill value) byteOffset (encodeEncoding encoding) buffer

{-| -}
lastIndexOf: Fill -> Buffer -> Int
lastIndexOf value buffer =
  Native.Node.Buffer.lastIndexOf (encodeFill value) buffer

{-| -}
lastIndexOf2: Fill -> Int -> Buffer -> Int
lastIndexOf2 value byteOffset buffer =
  Native.Node.Buffer.lastIndexOf2 (encodeFill value) byteOffset buffer

{-| -}
lastIndexOf3: Fill -> Int -> Encoding -> Buffer -> Int
lastIndexOf3 value byteOffset encoding buffer =
  Native.Node.Buffer.lastIndexOf3 (encodeFill value) byteOffset (encodeEncoding encoding) buffer

{-| -}
length: Buffer -> Int
length =
  Native.Node.Buffer.length

{-| -}
slice: Buffer -> Buffer
slice =
  Native.Node.Buffer.slice

{-| -}
slice2: Int -> Buffer -> Buffer
slice2 =
  Native.Node.Buffer.slice2

{-| -}
slice3: Int -> Int -> Buffer -> Buffer
slice3 =
  Native.Node.Buffer.slice3

{-| -}
toJSON: Buffer -> Encode.Value
toJSON =
  Native.Node.Buffer.toJSON

{-| -}
stringify: Buffer -> String
stringify =
  Native.Node.Buffer.stringify

{-| -}
stringify2: Encoding -> Buffer -> String
stringify2 enc buffer =
  Native.Node.Buffer.stringify2 (encodeEncoding enc) buffer

{-| -}
stringify3: Encoding -> Int -> Buffer -> String
stringify3 enc start buffer =
  Native.Node.Buffer.stringify3 (encodeEncoding enc) start buffer

{-| -}
stringify4: Encoding -> Int -> Int -> Buffer -> String
stringify4 enc start end buffer =
  Native.Node.Buffer.stringify3 (encodeEncoding enc) start end buffer

{-| -}
transcode: Encoding -> Encoding -> Buffer -> Buffer
transcode fromEnc toEnc buffer =
  Native.Node.Buffer.transcode (encodeEncoding fromEnc) (encodeEncoding toEnc) buffer



-- -----------------------------------------------------------------------------
-- Constants

{-| -}
maxLength: Int
maxLength =
  Native.Node.Buffer.maxLength

{-| -}
maxStringLength: Int
maxStringLength =
  Native.Node.Buffer.maxStringLength

{-| -}
inspectMaxBytes: Int
inspectMaxBytes =
  Native.Node.Buffer.inspectMaxBytes

-- -----------------------------------------------------------------------------
-- JSON

encodeFill: Fill -> Encode.Value
encodeFill fill =
  case fill of
    FillString str    -> Encode.string str
    FillInt int       -> Encode.int int
    FillBuffer buffer -> toValue buffer

toValue: a -> Encode.Value
toValue =
  Native.Node.Buffer.identity
