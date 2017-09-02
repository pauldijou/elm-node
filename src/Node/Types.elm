module Node.Types exposing
  ( Encoding(..)
  , defaultEncoding
  , Depth(..)
  )

{-|
@docs Encoding, defaultEncoding, Depth
-}

{-| -}
type Encoding = Ascii | Utf8 | Utf16le | Ucs2 | Base64 | Latin1 | Binary | Hex

{-| -}
defaultEncoding: Encoding
defaultEncoding = Utf8

{-| Specifies the number of times to recurse while formatting the object. This is useful for inspecting large complicated objects. -}
type Depth = Depth Int | Infinite
