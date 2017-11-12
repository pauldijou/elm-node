port module NodeTest exposing (..)

import Ordeal exposing (..)

import Node.ChildProcessTest
import Node.ConsoleTest
import Node.FileSystemTest
import Node.GlobalsTest
import Node.HttpTest
import Node.PathTest
import Node.ProcessTest
import Node.StatsTest
import Node.UtilTest

main: Ordeal
main = run emit all

port emit : Event -> Cmd msg

all: Test
all =
  describe "Node"
    [ Node.ChildProcessTest.tests
    , Node.ConsoleTest.tests
    , Node.FileSystemTest.tests
    , Node.GlobalsTest.tests
    , Node.GlobalsTest.tests
    , Node.HttpTest.tests
    , Node.ProcessTest.tests
    , Node.StatsTest.tests
    , Node.UtilTest.tests
    ]
