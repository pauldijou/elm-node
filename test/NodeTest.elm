port module NodeTest exposing (..)

import Ordeal exposing (..)

import Node.ConsoleTest
import Node.FileSystemTest
import Node.PathTest
import Node.ProcessTest
import Node.UtilTest

main: Ordeal
main = run emit all

port emit : Event -> Cmd msg

all: Test
all =
  describe "Node"
    [ Node.ConsoleTest.tests
    , Node.FileSystemTest.tests
    , Node.PathTest.tests
    , Node.ProcessTest.tests
    , Node.UtilTest.tests
    ]
