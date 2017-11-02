const _pauldijou$elm_node$Native_Node_ChildProcess = function () {
  const childProcess = require('child_process');
  const helpers = _pauldijou$elm_kernel_helpers$Native_Kernel_Helpers;
  const parseError = _pauldijou$elm_error$Error$parse;

  function exec(cmd, options) {
    return helpers.task.fromCallback((succeed, fail) => {
      childProcess.exec(cmd, options, (error, stdout, stderr) => {
        if (error) { fail(parseError(error)) }
        else { succeed({ stdout, stderr }) }
      })
    })
  }

  function execFile(cmd, args, options) {
    return helpers.task.fromCallback((succeed, fail) => {
      childProcess.execFile(cmd, args, options, (error, stdout, stderr) => {
        if (error) { fail(parseError(error)) }
        else { succeed({ stdout, stderr }) }
      })
    })
  }

  return {
    exec: F2(exec),
    execFile: F3(execFile),
  }
}()
