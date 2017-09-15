const _pauldijou$elm_node$Native_Node_Test_Helpers = function () {
  const mock = require('mock-fs')
  const recursiveValue = { a: 1 }
  recursiveValue.b = recursiveValue

  const deepValue = { next: { next: { next: { done: true }}}}

  const uid = 1
  const gid = 2
  const birthtimeMs = 100
  const ctimeMs = 200
  const mtimeMs = 300
  const atimeMs = 400
  const birthtime = new Date(birthtimeMs)
  const ctime = new Date(ctimeMs)
  const mtime = new Date(mtimeMs)
  const atime = new Date(atimeMs)

  function normalize(options) {
    options.uid = uid
    options.gid = gid
    options.birthtime = birthtime
    options.ctime = ctime
    options.mtime = mtime
    options.atime = atime
    return options
  }

  function octal(value) {
    return parseInt(value, 8)
  }

  mock({
    folder: mock.directory(normalize({
      mode: octal('0777'),
      items: {}
    })),
    file: mock.file(normalize({
      mode: octal('0666'),
      content: 'content'
    })),
    symlink: mock.symlink(normalize({
      mode: octal('0666'),
      path: 'file'
    }))
  }, {
    createCwd: false,
    createTmp: false
  })

  process.on('exit', () => {
    console.log('Restoring file system')
    mock.restore()
  })

  return {
    uid: uid,
    gid: gid,
    birthtimeMs: birthtimeMs,
    ctimeMs: ctimeMs,
    mtimeMs: mtimeMs,
    atimeMs: atimeMs,
    birthtime: birthtime,
    ctime: ctime,
    mtime: mtime,
    atime: atime,
    recursiveValue: recursiveValue,
    deepValue: deepValue
  }
}()
