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

{-| https://nodejs.org/docs/latest/api/process.html#process_exit_codes


@docs uncaughtFatalException, internalJavaScriptParseError, internalJavaScriptEvaluationFailure, fatalError, nonFunctionInternalExceptionHandler, internalExceptionHandlerRunTimeFailure, invalidArgument, internalJavaScriptRunTimeFailure, invalidDebugArgument

-}

{-| -}
uncaughtFatalException: Int
uncaughtFatalException = 0

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
