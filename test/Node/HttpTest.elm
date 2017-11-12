module Node.HttpTest exposing (tests)

import Ordeal exposing (..)

import Node.Http as Http

tests: Test
tests =
  describe "Http"
    [ test "createServer" (
      success
    )
    ]
