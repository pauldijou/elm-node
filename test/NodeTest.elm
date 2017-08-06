port module NodeTest exposing (..)

import Ordeal exposing (..)

import Node.PathTest
import Node.UtilTest

main: Ordeal
main = run emit all

port emit : Event -> Cmd msg

all: Test
all =
  describe "Node"
    [ Node.PathTest.all
    , Node.UtilTest.all
    ]
