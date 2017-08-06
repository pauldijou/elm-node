port module NodeTest exposing (..)

import Ordeal exposing (..)

import Node.PathTest
import Node.ProcessTest
import Node.UtilTest

main: Ordeal
main = run emit all

port emit : Event -> Cmd msg

all: Test
all =
  describe "Node"
    [ Node.PathTest.all
    , Node.ProcessTest.all
    , Node.UtilTest.all
    ]
