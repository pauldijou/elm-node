const _pauldijou$elm_node$Native_Node_Console = function () {
  // const Console = require('console')

  function identity(a) { return a }
  function identity2(a, b) { return b }

  function clear(value) { console.clear(); return value }
  function count(label, value) { console.count(label); return value }
  function countReset(label, value) { console.countReset(label); return value }
  function dir(value) { console.dir(value); return value }
  function dir2(options, value) { console.dir(value, options); return value }
  function error(value) { console.error(value); return value }
  function info(value) { console.info(value); return value }
  function log(value) { console.log(value); return value }
  function warn(value) { console.warn(value); return value }
  function time(label, value) { console.time(label); return value }
  function timeEnd(label, value) { console.timeEnd(label); return value }
  function trace(message, value) { console.trace(message); return value }

  return {
    clear: typeof console.clear === 'function' ? clear : identity,
    count: typeof console.count === 'function' ? F2(count) : F2(identity2),
    countReset: typeof console.countReset === 'function' ? F2(countReset) : F2(identity2),
    dir: dir,
    dir2: F2(dir2),
    error: error,
    info: info,
    log: log,
    warn: warn,
    time: F2(time),
    timeEnd: F2(timeEnd),
    trace: F2(trace)
  }
}()
