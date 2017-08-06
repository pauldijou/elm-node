module Node.Helpers exposing (..)

import Dict exposing (Dict)
import Json.Encode as Encode

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
