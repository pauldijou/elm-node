module Node.Encoding exposing (Encoding(..), defaultEncoding)

{-|

@docs Encoding, defaultEncoding

-}

import Json.Encode as Encode

{-| -}
type Encoding = Ascii | Utf8 | Utf16le | Ucs2 | Base64 | Latin1 | Binary | Hex

{-| -}
defaultEncoding: Encoding
defaultEncoding = Utf8
