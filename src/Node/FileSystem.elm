module Node.FileSystem exposing
  ( access
  , accessSync
  , constants
  )

{-|
Node API: https://nodejs.org/api/fs.html

@docs access, accessSync, constants
-}

import Task exposing (Task)
import Error exposing (Error)

import Node.Stats exposing (Stats)
import Native.Node.FileSystem

type alias AccessConstant = Int
type alias OpenConstant = Int
type alias ModeConstant = Int

{-| -}
access: String -> AccessConstant -> Task Error ()
access = Native.Node.FileSystem.access

{-| -}
accessSync: String -> AccessConstant -> Result Error ()
accessSync = Native.Node.FileSystem.accessSync

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
