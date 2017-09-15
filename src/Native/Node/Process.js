const _pauldijou$elm_node$Native_Node_Process = function () {
  const process = require('process')
  const helpers = _pauldijou$elm_kernel_helpers$Native_Kernel_Helpers

  const abort = helpers.task.fromCallback(succeed => {
    process.abort()
    succeed()
  })

  function chdir(directory) {
    return helpers.task.fromCallback((succeed, fail) => {
      try {
        process.chdir(directory)
        succeed()
      } catch (e) {
        fail('' + e)
      }
    })
  }

  const connected = helpers.task.fromCallback(succeed => {
    succeed(!!process.connected)
  })

  const cpuUsage = helpers.task.fromCallback(succeed => {
    succeed(process.cpuUsage())
  })

  function cpuUsageSince(since) {
    return helpers.task.fromCallback(succeed => {
      succeed(process.cpuUsage(since))
    })
  }

  const cwd = helpers.task.fromCallback(succeed => {
    succeed(process.cwd())
  })

  const disconnect = helpers.task.fromCallback(succeed => {
    process.disconnect()
    succeed()
  })

  function exit(code) {
    return helpers.task.fromCallback(succeed => {
      process.exit(code)
      succeed()
    })
  }

  const hrtime = helpers.task.fromCallback(succeed => {
    const hrtime = process.hrtime()
    succeed({ seconds: hrtime[0], nanoseconds: hrtime[1] })
  })

  function hrtimeSince(since) {
    return helpers.task.fromCallback(succeed => {
      const hrtime = process.hrtime([ since.seconds, since.nanoseconds ])
      succeed({ seconds: hrtime[0], nanoseconds: hrtime[1] })
    })
  }

  function kill(pid, signal) {
    return helpers.task.fromCallback(succeed => {
      process.kill(pid, signal)
      succeed()
    })
  }

  function killWith(signal, pid) {
    return kill(pid, signal)
  }

  const memoryUsage = helpers.task.fromCallback(succeed => {
    succeed(process.memoryUsage())
  })

  const title = helpers.task.fromCallback(succeed => {
    succeed(process.title)
  })

  function withTitle(title) {
    return helpers.task.fromCallback(succeed => {
      process.title = title
      succeed()
    })
  }

  const uptime = helpers.task.fromCallback(succeed => {
    succeed(process.uptime())
  })

  return {
    abort: abort,
    arch: process.arch,
    argv: helpers.list.fromArray(process.argv),
    argv0: process.argv0,
    chdir: chdir,
    config: process.config,
    connected: connected,
    cpuUsage: cpuUsage,
    cpuUsageSince: cpuUsageSince,
    cwd: cwd,
    disconnect: disconnect,
    env: process.env,
    execArgv: helpers.list.fromArray(process.execArgv),
    execPath: process.execPath,
    exit: exit,
    hrtime: hrtime,
    hrtimeSince: hrtimeSince,
    kill: kill,
    killWith: F2(killWith),
    memoryUsage: memoryUsage,
    pid: process.pid,
    platform: process.platform,
    release: process.release,
    title: title,
    withTitle: withTitle,
    uptime: uptime,
    version: process.version,
    versions: process.versions
  }
}()
