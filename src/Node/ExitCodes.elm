module Node.ExitCodes exposing
  ( uncaughtFatalException
  , internalJavaScriptParseError
  , internalJavaScriptEvaluationFailure
  , fatalError
  , nonFunctionInternalExceptionHandler
  , internalExceptionHandlerRunTimeFailure
  , invalidArgument
  , internalJavaScriptRunTimeFailure
  , invalidDebugArgument
  )

{-|
Node API: https://nodejs.org/docs/latest/api/process.html#process_exit_codes

@docs uncaughtFatalException, internalJavaScriptParseError, internalJavaScriptEvaluationFailure, fatalError, nonFunctionInternalExceptionHandler, internalExceptionHandlerRunTimeFailure, invalidArgument, internalJavaScriptRunTimeFailure, invalidDebugArgument
-}

{-| -}
ok: Int
ok = 0

{-| -}
uncaughtFatalException: Int
uncaughtFatalException = 1

{-| -}
internalJavaScriptParseError: Int
internalJavaScriptParseError = 3

{-| -}
internalJavaScriptEvaluationFailure: Int
internalJavaScriptEvaluationFailure = 4

{-| -}
fatalError: Int
fatalError = 5

{-| -}
nonFunctionInternalExceptionHandler: Int
nonFunctionInternalExceptionHandler = 6

{-| -}
internalExceptionHandlerRunTimeFailure: Int
internalExceptionHandlerRunTimeFailure = 7

{-| -}
invalidArgument: Int
invalidArgument = 9

{-| -}
internalJavaScriptRunTimeFailure: Int
internalJavaScriptRunTimeFailure = 10

{-| -}
invalidDebugArgument: Int
invalidDebugArgument = 12
