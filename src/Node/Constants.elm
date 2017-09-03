module Node.Constants exposing
  ( ExitCode
  , FileAccess
  , FileOpen
  , FileType
  , FileMode
  , exitCodes
  , fileAccess
  , fileOpen
  , fileType
  , fileMode
  , allFileAccess
  )

{-|
@docs ExitCode, FileAccess, FileOpen, FileType, FileMode

@docs exitCodes, fileAccess, fileOpen, fileType, fileMode

@docs allFileAccess
-}

import Bitwise
import Native.Node.FileSystem

{-| -}
type alias ExitCode = Int
{-| -}
type alias FileAccess = Int
{-| -}
type alias FileOpen = Int
{-| -}
type alias FileType = Int
{-| -}
type alias FileMode = Int

{-|
Node API: https://nodejs.org/docs/latest/api/process.html#process_exit_codes
-}
exitCodes:
  { ok: Int
  , uncaughtFatalException: Int
  , internalJavaScriptParseError: Int
  , internalJavaScriptEvaluationFailure: Int
  , fatalError: Int
  , nonFunctionInternalExceptionHandler: Int
  , internalExceptionHandlerRunTimeFailure: Int
  , invalidArgument: Int
  , internalJavaScriptRunTimeFailure: Int
  , invalidDebugArgument: Int
  }
exitCodes =
  { ok = 0
  , uncaughtFatalException = 1
  , internalJavaScriptParseError = 3
  , internalJavaScriptEvaluationFailure = 4
  , fatalError = 5
  , nonFunctionInternalExceptionHandler = 6
  , internalExceptionHandlerRunTimeFailure = 7
  , invalidArgument = 9
  , internalJavaScriptRunTimeFailure = 10
  , invalidDebugArgument = 12
  }

{-|
The following constants are meant for use with fs.access().
-}
fileAccess:
  { visible : FileAccess
  , read : FileAccess
  , write : FileAccess
  , execute : FileAccess
  }
fileAccess =
  { visible = Native.Node.FileSystem.F_OK
  , read = Native.Node.FileSystem.R_OK
  , write = Native.Node.FileSystem.W_OK
  , execute = Native.Node.FileSystem.X_OK
  }

{-| -}
allFileAccess: List FileAccess -> FileAccess
allFileAccess list =
  case list of
    [] -> 0
    first :: rest -> List.foldl Bitwise.or first rest

{-|
The following constants are meant for use with fs.open().
-}
fileOpen:
  { readOnly : FileOpen
  , writeOnly : FileOpen
  , readWrite : FileOpen
  , create : FileOpen
  , failIfExists : FileOpen
  , terminalDevice : FileOpen
  , truncate : FileOpen
  , append : FileOpen
  , directory : FileOpen
  , noAtime : FileOpen
  , noFollow : FileOpen
  , synchronous : FileOpen
  , symlink : FileOpen
  , direct : FileOpen
  , nonblocking : FileOpen
  }
fileOpen =
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

{-|
The following constants are meant for use with the fs.Stats object's mode property for determining a file's type.
-}
fileType:
  { mask : FileType
  , file : FileType
  , directory : FileType
  , characterOrientedFile : FileType
  , blockOrientedFile : FileType
  , fifo : FileType
  , symlink : FileType
  , socket : FileType
  }
fileType =
  { mask = Native.Node.FileSystem.S_IFMT
  , file = Native.Node.FileSystem.S_IFREG
  , directory = Native.Node.FileSystem.S_IFDIR
  , characterOrientedFile = Native.Node.FileSystem.S_IFCHR
  , blockOrientedFile = Native.Node.FileSystem.S_IFBLK
  , fifo = Native.Node.FileSystem.S_IFIFO
  , symlink = Native.Node.FileSystem.S_IFLNK
  , socket = Native.Node.FileSystem.S_IFSOCK
  }

{-|
The following constants are meant for use with the fs.Stats object's mode property for determining the access permissions for a file.
-}
fileMode:
  { owner :
    { all : FileMode
    , read : FileMode
    , write : FileMode
    , execute : FileMode
    }
  , group :
    { all : FileMode
    , read : FileMode
    , write : FileMode
    , execute : FileMode
    }
  , others :
    { all : FileMode
    , read : FileMode
    , write : FileMode
    , execute : FileMode
    }
  }
fileMode =
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
