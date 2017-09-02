module Node.FileSystem exposing
  ( constants
  , access
  , accessSync
  , appendFile
  , appendFileBuffer
  , appendFileDescriptor
  , appendFileSync
  , appendFileSyncBuffer
  , appendFileSyncDescriptor
  , chmod
  , chmodSync
  , chown
  , chownSync
  , close
  , closeSync
  , fchmod
  , fchmodSync
  , fchown
  , fchownSync
  , fdatasync
  , fdatasyncSync
  , fstat
  , fstatSync
  , fsync
  , fsyncSync
  , ftruncate
  , ftruncateSync
  , futimes
  , futimesSync
  , lchown
  , lchownBuffer
  , lchownSync
  , lchownSyncBuffer
  , link
  , linkSync
  , lstat
  , lstatSync
  , mkdir
  , mkdirSync
  , mkdtemp
  , mkdtempSync
  , open
  , openSync
  , read
  , readSync
  , readdir
  , readdirSync
  , readFile
  , readFileSync
  , readlink
  , readlinkSync
  , realpath
  , realpathSync
  , rename
  , renameSync
  , rmdir
  , rmdirSync
  , stat
  , statSync
  , symlink
  , symlinkSync
  , truncate
  , truncateSync
  , unlink
  , unlinkSync
  , utimes
  , utimesSync
  )

{-|
Node API: https://nodejs.org/api/fs.html

@docs constants, access, accessSync, appendFile, appendFileBuffer, appendFileDescriptor, appendFileSync, appendFileSyncBuffer, appendFileSyncDescriptor, chmod, chmodSync, chown, chownSync, close, closeSync, fchmod, fchmodSync, fchown, fchownSync, fdatasync, fdatasyncSync, fstat, fstatSync, fsync, fsyncSync, ftruncate, ftruncateSync, futimes, futimesSync, lchown, lchownBuffer, lchownSync, lchownSyncBuffer, link, linkSync, lstat, lstatSync, mkdir, mkdirSync, mkdtemp, mkdtempSync, open, openSync, read, readSync, readdir, readdirSync, readFile, readFileSync, readlink, readlinkSync, realpath, realpathSync, rename, renameSync, rmdir, rmdirSync, stat, statSync, symlink, symlinkSync, truncate, truncateSync, unlink, unlinkSync, utimes, utimesSync
-}

import Task exposing (Task)
import Json.Encode as Encode
import Error exposing (Error)

import Node.Buffer exposing (Buffer)
import Node.Stats exposing (Stats)
import Node.Types exposing (Encoding)
import Node.Internals exposing (encodeEncoding)
import Native.Node.FileSystem

type alias AccessConstant = Int
type alias OpenConstant = Int
type alias ModeConstant = Int

type alias Descriptor = Int
type alias Mode = Int
type Data = DataString String | DataBuffer Buffer
type alias Options = { encoding: Maybe Encoding, mode: Maybe Mode, flag: Maybe String }
type SymlinkType = File | Dir | Junction

defaultOptions: Options
defaultOptions =
  { encoding = Nothing, mode = Nothing, flag = Nothing }

{-| -}
access: String -> AccessConstant -> Task Error ()
access = Native.Node.FileSystem.access

{-| -}
accessSync: String -> AccessConstant -> Result Error ()
accessSync = Native.Node.FileSystem.accessSync

{-| -}
appendFile: String -> Data -> Options -> Task Error ()
appendFile path data options =
  Native.Node.FileSystem.appendFile path (encodeData data) (encodeOptions options)

{-| -}
appendFileBuffer: Descriptor -> Data -> Options -> Task Error ()
appendFileBuffer descriptor data options =
  Native.Node.FileSystem.appendFile descriptor (encodeData data) (encodeOptions options)

{-| -}
appendFileDescriptor: Buffer -> Data -> Options -> Task Error ()
appendFileDescriptor buffer data options =
  Native.Node.FileSystem.appendFile buffer (encodeData data) (encodeOptions options)

{-| -}
appendFileSync: String -> Data -> Options -> Result Error ()
appendFileSync path data options =
  Native.Node.FileSystem.appendFileSync path (encodeData data) (encodeOptions options)

{-| -}
appendFileSyncBuffer: Buffer -> Data -> Options -> Result Error ()
appendFileSyncBuffer buffer data options =
  Native.Node.FileSystem.appendFileSync buffer (encodeData data) (encodeOptions options)

{-| -}
appendFileSyncDescriptor: Descriptor -> Data -> Options -> Result Error ()
appendFileSyncDescriptor descriptor data options =
  Native.Node.FileSystem.appendFileSync descriptor (encodeData data) (encodeOptions options)

{-| -}
chmod: String -> Mode -> Task Error ()
chmod = Native.Node.FileSystem.chmod

{-| -}
chmodSync: String -> Mode -> Result Error ()
chmodSync = Native.Node.FileSystem.chmodSync

{-| -}
chown: String -> Int -> Int -> Task Error ()
chown = Native.Node.FileSystem.chown

{-| -}
chownSync: String -> Int -> Int -> Result Error ()
chownSync = Native.Node.FileSystem.chownSync

{-| -}
close: Descriptor -> Task Error ()
close = Native.Node.FileSystem.close

{-| -}
closeSync: Descriptor -> Result Error ()
closeSync = Native.Node.FileSystem.closeSync

{-| -}
fchmod: Descriptor -> Mode -> Task Error ()
fchmod = Native.Node.FileSystem.fchmod

{-| -}
fchmodSync: Descriptor -> Mode -> Result Error ()
fchmodSync = Native.Node.FileSystem.fchmodSync

{-| -}
fchown: Descriptor -> Int -> Int -> Task Error ()
fchown = Native.Node.FileSystem.fchown

{-| -}
fchownSync: Descriptor -> Int -> Int -> Result Error ()
fchownSync = Native.Node.FileSystem.fchownSync

{-| -}
fdatasync: Descriptor -> Task Error ()
fdatasync = Native.Node.FileSystem.fdatasync

{-| -}
fdatasyncSync: Descriptor -> Result Error ()
fdatasyncSync = Native.Node.FileSystem.fdatasyncSync

{-| -}
fstat: Descriptor -> Task Error Stats
fstat = Native.Node.FileSystem.fstat

{-| -}
fstatSync: Descriptor -> Result Error Stats
fstatSync = Native.Node.FileSystem.fstatSync

{-| -}
fsync: Descriptor -> Task Error ()
fsync = Native.Node.FileSystem.fsync

{-| -}
fsyncSync: Descriptor -> Result Error ()
fsyncSync = Native.Node.FileSystem.fsyncSync

{-| -}
ftruncate: Descriptor -> Int -> Task Error ()
ftruncate = Native.Node.FileSystem.ftruncate

{-| -}
ftruncateSync: Descriptor -> Int -> Result Error ()
ftruncateSync = Native.Node.FileSystem.ftruncateSync

{-| -}
futimes: Descriptor -> Int -> Int -> Task Error ()
futimes = Native.Node.FileSystem.futimes

{-| -}
futimesSync: Descriptor -> Int -> Int -> Result Error ()
futimesSync = Native.Node.FileSystem.futimesSync

{-| -}
lchown: String -> Int -> Int -> Task Error ()
lchown = Native.Node.FileSystem.lchown

{-| -}
lchownBuffer: Buffer -> Int -> Int -> Task Error ()
lchownBuffer = Native.Node.FileSystem.lchown

{-| -}
lchownSync: String -> Int -> Int -> Result Error ()
lchownSync = Native.Node.FileSystem.lchownSync

{-| -}
lchownSyncBuffer: Buffer -> Int -> Int -> Result Error ()
lchownSyncBuffer = Native.Node.FileSystem.lchownSync

{-| -}
link: String -> String -> Task Error ()
link = Native.Node.FileSystem.link

{-| -}
linkSync: String -> String -> Result Error ()
linkSync = Native.Node.FileSystem.linkSync

{-| -}
lstat: String -> Task Error Stats
lstat = Native.Node.FileSystem.lstat

{-| -}
lstatSync: String -> Result Error Stats
lstatSync = Native.Node.FileSystem.lstatSync

{-| -}
mkdir: String -> Mode -> Task Error Stats
mkdir = Native.Node.FileSystem.mkdir

{-| -}
mkdirSync: String -> Mode -> Result Error Stats
mkdirSync = Native.Node.FileSystem.mkdirSync

{-| -}
mkdtemp: String -> Encoding -> Task Error String
mkdtemp prefix encoding =
  Native.Node.FileSystem.mkdtemp prefix (encodeEncoding encoding)

{-| -}
mkdtempSync: String -> Encoding -> Result Error String
mkdtempSync prefix encoding =
  Native.Node.FileSystem.mkdtempSync prefix (encodeEncoding encoding)

{-| -}
open: String -> String -> Int -> Task Error Descriptor
open = Native.Node.FileSystem.open

{-| -}
openSync: String -> String -> Int -> Result Error Descriptor
openSync = Native.Node.FileSystem.openSync

{-| -}
read: Descriptor -> Buffer -> Int -> Int -> Maybe Int -> Task Error (Int, Buffer)
read d b o l p =
  Native.Node.FileSystem.read d b o l (intOrNull p)

{-| -}
readSync: Descriptor -> Buffer -> Int -> Int -> Maybe Int -> Result Error Int
readSync d b o l p =
  Native.Node.FileSystem.readSync d b o l (intOrNull p)

{-| -}
readdir: String -> Encoding -> Task Error (List String)
readdir path enc =
  Native.Node.FileSystem.readdir path (encodeEncoding enc)

{-| -}
readdirSync: String -> Encoding -> Result Error (List String)
readdirSync path enc =
  Native.Node.FileSystem.readdirSync path (encodeEncoding enc)

{-| -}
readFile: String -> { encoding: Encoding, flag: String } -> Task Error String
readFile path options =
  Native.Node.FileSystem.readFile path { encoding = encodeEncoding options.encoding, flag = options.flag }

{-| -}
readFileSync: String -> { encoding: Encoding, flag: String } -> Result Error String
readFileSync path options =
  Native.Node.FileSystem.readFileSync path { encoding = encodeEncoding options.encoding, flag = options.flag }

{-| -}
readlink: String -> Encoding -> Task Error String
readlink path enc =
  Native.Node.FileSystem.readlink path (encodeEncoding enc)

{-| -}
readlinkSync: String -> Encoding -> Result Error String
readlinkSync path enc =
  Native.Node.FileSystem.readlinkSync path (encodeEncoding enc)

{-| -}
realpath: String -> Encoding -> Task Error String
realpath path enc =
  Native.Node.FileSystem.realpath path (encodeEncoding enc)

{-| -}
realpathSync: String -> Encoding -> Result Error String
realpathSync path enc =
  Native.Node.FileSystem.realpathSync path (encodeEncoding enc)

{-| -}
rename: String -> String -> Task Error ()
rename = Native.Node.FileSystem.rename

{-| -}
renameSync: String -> String -> Result Error ()
renameSync = Native.Node.FileSystem.renameSync

{-| -}
rmdir: String -> Task Error ()
rmdir = Native.Node.FileSystem.rmdir

{-| -}
rmdirSync: String -> Result Error ()
rmdirSync = Native.Node.FileSystem.rmdirSync

{-| -}
stat: String -> Task Error Stats
stat = Native.Node.FileSystem.stat

{-| -}
statSync: String -> Result Error Stats
statSync = Native.Node.FileSystem.statSync

{-| -}
symlink: String -> String -> SymlinkType -> Task Error Stats
symlink target path stype =
  Native.Node.FileSystem.symlink target path (encodeSymlinkType stype)

{-| -}
symlinkSync: String -> String -> SymlinkType -> Result Error Stats
symlinkSync target path stype =
  Native.Node.FileSystem.symlinkSync target path (encodeSymlinkType stype)

{-| -}
truncate: String -> Int -> Task Error ()
truncate = Native.Node.FileSystem.truncate

{-| -}
truncateSync: String -> Int -> Result Error ()
truncateSync = Native.Node.FileSystem.truncateSync

{-| -}
unlink: String -> Task Error ()
unlink = Native.Node.FileSystem.unlink

{-| -}
unlinkSync: String -> Result Error ()
unlinkSync = Native.Node.FileSystem.unlinkSync

{-| -}
utimes: String -> Int -> Int -> Task Error ()
utimes = Native.Node.FileSystem.utimes

{-| -}
utimesSync: String -> Int -> Int -> Result Error ()
utimesSync = Native.Node.FileSystem.utimesSync

{-| -}
constants :
  { access :
    { execute : AccessConstant
    , read : AccessConstant
    , visible : AccessConstant
    , write : AccessConstant
    }
  , open :
    { append : OpenConstant
    , create : OpenConstant
    , direct : OpenConstant
    , directory : OpenConstant
    , failIfExists : OpenConstant
    , noAtime : OpenConstant
    , noFollow : OpenConstant
    , nonblocking : OpenConstant
    , readOnly : OpenConstant
    , readWrite : OpenConstant
    , symlink : OpenConstant
    , synchronous : OpenConstant
    , terminalDevice : OpenConstant
    , truncate : OpenConstant
    , writeOnly : OpenConstant
    }
  , modeType :
    { blockOrientedFile : ModeConstant
    , characterOrientedFile : ModeConstant
    , directory : ModeConstant
    , fifo : ModeConstant
    , mask : ModeConstant
    , regularFile : ModeConstant
    , socket : ModeConstant
    , symlink : ModeConstant
    }
  , modeAccess :
    { group :
      { all : ModeConstant
      , execute : ModeConstant
      , read : ModeConstant
      , write : ModeConstant
      }
    , others :
      { all : ModeConstant
      , execute : ModeConstant
      , read : ModeConstant
      , write : ModeConstant
      }
    , owner :
      { all : ModeConstant
      , execute : ModeConstant
      , read : ModeConstant
      , write : ModeConstant
      }
    }
  }
constants =
  { access =
    { visible = Native.Node.FileSystem.F_OK
    , read = Native.Node.FileSystem.R_OK
    , write = Native.Node.FileSystem.W_OK
    , execute = Native.Node.FileSystem.X_OK
    }
  , open =
    { readOnly = Native.Node.FileSystem.O_RDONLY
    , writeOnly = Native.Node.FileSystem.O_WRONLY
    , readWrite = Native.Node.FileSystem.O_RDWR
    , create = Native.Node.FileSystem.O_CREAT
    , failIfExists = Native.Node.FileSystem.O_EXCL
    , terminalDevice = Native.Node.FileSystem.O_NOCTTY
    , truncate = Native.Node.FileSystem.O_TRUNC
    , append = Native.Node.FileSystem.O_APPEND
    , directory = Native.Node.FileSystem.O_DIRECTORY
    , noAtime = Native.Node.FileSystem.O_NOATIME
    , noFollow = Native.Node.FileSystem.O_NOFOLLOW
    , synchronous = Native.Node.FileSystem.O_SYNC
    , symlink = Native.Node.FileSystem.O_SYMLINK
    , direct = Native.Node.FileSystem.O_DIRECT
    , nonblocking = Native.Node.FileSystem.O_NONBLOCK
    }
  , modeType =
    { mask = Native.Node.FileSystem.S_IFMT
    , regularFile = Native.Node.FileSystem.S_IFREG
    , directory = Native.Node.FileSystem.S_IFDIR
    , characterOrientedFile = Native.Node.FileSystem.S_IFCHR
    , blockOrientedFile = Native.Node.FileSystem.S_IFBLK
    , fifo = Native.Node.FileSystem.S_IFIFO
    , symlink = Native.Node.FileSystem.S_IFLNK
    , socket = Native.Node.FileSystem.S_IFSOCK
    }
  , modeAccess =
    { owner =
      { all = Native.Node.FileSystem.S_IRWXU
      , read = Native.Node.FileSystem.S_IRUSR
      , write = Native.Node.FileSystem.S_IWUSR
      , execute = Native.Node.FileSystem.S_IXUSR
      }
    , group =
      { all = Native.Node.FileSystem.S_IRWXG
      , read = Native.Node.FileSystem.S_IRGRP
      , write = Native.Node.FileSystem.S_IWGRP
      , execute = Native.Node.FileSystem.S_IXGRP
      }
    , others =
      { all = Native.Node.FileSystem.S_IRWXO
      , read = Native.Node.FileSystem.S_IROTH
      , write = Native.Node.FileSystem.S_IWOTH
      , execute = Native.Node.FileSystem.S_IXOTH
      }
    }
  }


-- -----------------------------------------------------------------------------
-- JSON

encodeIdentity: a -> Encode.Value
encodeIdentity =
  Native.Node.FileSystem.identity

encodeData: Data -> Encode.Value
encodeData data =
  case data of
    DataString str -> Encode.string str
    DataBuffer buffer -> encodeIdentity buffer

encodeOptions: Options -> Encode.Value
encodeOptions options =
  [ Maybe.map (\enc -> ("encoding", encodeEncoding enc)) options.encoding
  , Maybe.map (\mode -> ("mode", Encode.int mode)) options.mode
  , Maybe.map (\flag -> ("flag", Encode.string flag)) options.flag
  ]
  |> List.filterMap identity
  |> Encode.object

encodeSymlinkType: SymlinkType -> Encode.Value
encodeSymlinkType stype =
  case stype of
    File -> Encode.string "file"
    Dir -> Encode.string "dir"
    Junction -> Encode.string "junction"

intOrNull: Maybe Int -> Encode.Value
intOrNull =
  (Maybe.map Encode.int) >> (Maybe.withDefault Encode.null)
