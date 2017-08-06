var _pauldijou$elm_node$Native_Node_Util = function () {
  const util = require('util')

  function inspectLog(value, options) {
    console.log(util.inspect(value, options));
    return value
  }

  return {
    inspect: F2(util.inspect),
    inspectLog: F2(inspectLog)
  }
}()
