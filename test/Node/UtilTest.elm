module Node.UtilTest exposing (all)

import Ordeal exposing (..)

import Node.Util as Util
import Native.Node.Test.Helpers

defaultOptions: Util.Options
defaultOptions = Util.defaultOptions

basicInspect: a -> String
basicInspect = Util.inspect Nothing

depth0: Util.Options
depth0 = { defaultOptions | depth = Just <| Util.Depth 0 }

depth1: Util.Options
depth1 = { defaultOptions | depth = Just <| Util.Depth 1 }

depth2: Util.Options
depth2 = { defaultOptions | depth = Just <| Util.Depth 2 }

depth3: Util.Options
depth3 = { defaultOptions | depth = Just <| Util.Depth 3 }

depthInfinite: Util.Options
depthInfinite = { defaultOptions | depth = Just <| Util.Infinite }

all: Test
all =
  describe "Util"
    [ test "inspect" (
      success
      |> andThen (basicInspect 1 |> shouldEqual "1" )
      |> andThen (basicInspect True |> shouldEqual "true" )
      |> andThen (basicInspect False |> shouldEqual "false" )
      |> andThen (basicInspect { a = 1 } |> shouldEqual "{ a: 1 }" )
    )
    , test "recursive structure" (
      basicInspect Native.Node.Test.Helpers.recursiveValue
      |> shouldEqual "{ a: 1, b: [Circular] }"
    )
    , test "depth" (
      success
      |> andThen(
        Util.inspect (Just depth0) Native.Node.Test.Helpers.deepValue
        |> shouldEqual "{ next: [Object] }"
      )
      |> andThen(
        Util.inspect (Just depth1) Native.Node.Test.Helpers.deepValue
        |> shouldEqual "{ next: { next: [Object] } }"
      )
      |> andThen(
        Util.inspect (Just depth2) Native.Node.Test.Helpers.deepValue
        |> shouldEqual "{ next: { next: { next: [Object] } } }"
      )
      |> andThen(
        Util.inspect (Just depth3) Native.Node.Test.Helpers.deepValue
        |> shouldEqual "{ next: { next: { next: { done: true } } } }"
      )
      |> andThen(
        Util.inspect (Just depthInfinite) Native.Node.Test.Helpers.deepValue
        |> shouldEqual "{ next: { next: { next: { done: true } } } }"
      )
    )
    ]
