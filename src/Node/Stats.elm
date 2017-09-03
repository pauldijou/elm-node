module Node.Stats exposing
  ( Stats
  , isFile
  , isDirectory
  , isBlockDevice
  , isCharacterDevice
  , isSymbolicLink
  , isFIFO
  , isSocket
  , is
  , hasPermission
  , toOctalPermissions
  , dev
  , ino
  , mode
  , nlink
  , uid
  , gid
  , rdev
  , size
  , blksize
  , blocks
  , atimeMs
  , mtimeMs
  , ctimeMs
  , birthtimeMs
  , atime
  , mtime
  , ctime
  , birthtime
  )

{-|
Node API: https://nodejs.org/api/fs.html#fs_class_fs_stats

Objects returned from fs.stat(), fs.lstat() and fs.fstat() and their synchronous counterparts are of this type.

@docs Stats, isFile, isDirectory, isBlockDevice, isCharacterDevice, isSymbolicLink, isFIFO, isSocket, is, hasPermission, toOctalPermissions, dev, ino, mode, nlink, uid, gid, rdev, size, blksize, blocks, atimeMs, mtimeMs, ctimeMs, birthtimeMs, atime, mtime, ctime, birthtime
-}

import Bitwise
import Date exposing (Date)
import Node.Constants as Constants exposing (fileType)
import Native.Node.Stats

{-| -}
type Stats = Stats

{-| -}
isFile: Stats -> Bool
isFile = Native.Node.Stats.isFile

{-| -}
isDirectory: Stats -> Bool
isDirectory = Native.Node.Stats.isDirectory

{-| -}
isBlockDevice: Stats -> Bool
isBlockDevice = Native.Node.Stats.isBlockDevice

{-| -}
isCharacterDevice: Stats -> Bool
isCharacterDevice = Native.Node.Stats.isCharacterDevice

{-| -}
isSymbolicLink: Stats -> Bool
isSymbolicLink = Native.Node.Stats.isSymbolicLink

{-| -}
isFIFO: Stats -> Bool
isFIFO = Native.Node.Stats.isFIFO

{-| -}
isSocket: Stats -> Bool
isSocket = Native.Node.Stats.isSocket

{-| -}
is: Constants.FileType -> Stats -> Bool
is ft stats =
  (Bitwise.and fileType.mask (mode stats)) == ft

{-| -}
hasPermission: Constants.FileMode -> Stats -> Bool
hasPermission fm stats =
  (Bitwise.and (mode stats) fm) /= 0

{-| -}
toOctalPermissions: Stats -> String
toOctalPermissions stats =
  mode stats
  |> Bitwise.and 511 -- int for octal 0777
  |> toStringRadix 8
  |> (++) "0"

toStringRadix: Int -> Int -> String
toStringRadix = Native.Node.Stats.toStringRadix

{-| -}
dev: Stats -> Int
dev = Native.Node.Stats.dev

{-| -}
ino: Stats -> Int
ino = Native.Node.Stats.ino

{-| -}
mode: Stats -> Int
mode = Native.Node.Stats.mode

{-| -}
nlink: Stats -> Int
nlink = Native.Node.Stats.nlink

{-| -}
uid: Stats -> Int
uid = Native.Node.Stats.uid

{-| -}
gid: Stats -> Int
gid = Native.Node.Stats.gid

{-| -}
rdev: Stats -> Int
rdev = Native.Node.Stats.rdev

{-| -}
size: Stats -> Int
size = Native.Node.Stats.size

{-| -}
blksize: Stats -> Int
blksize = Native.Node.Stats.blksize

{-| -}
blocks: Stats -> Int
blocks = Native.Node.Stats.blocks

{-| -}
atimeMs: Stats -> Float
atimeMs = Native.Node.Stats.atimeMs

{-| -}
mtimeMs: Stats -> Float
mtimeMs = Native.Node.Stats.mtimeMs

{-| -}
ctimeMs: Stats -> Float
ctimeMs = Native.Node.Stats.ctimeMs

{-| -}
birthtimeMs: Stats -> Float
birthtimeMs = Native.Node.Stats.birthtimeMs

{-| -}
atime: Stats -> Date
atime = Native.Node.Stats.atime

{-| -}
mtime: Stats -> Date
mtime = Native.Node.Stats.mtime

{-| -}
ctime: Stats -> Date
ctime = Native.Node.Stats.ctime

{-| -}
birthtime: Stats -> Date
birthtime = Native.Node.Stats.birthtime
