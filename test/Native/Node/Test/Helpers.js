const _pauldijou$elm_node$Native_Node_Test_Helpers = function () {
  const mock = require('mock-fs')
  const recursiveValue = { a: 1 }
  recursiveValue.b = recursiveValue

  const deepValue = { next: { next: { next: { done: true }}}}

  const uid = 1
  const gid = 2
  const birthtime = new Date(100)
  const ctime = new Date(200)
  const mtime = new Date(300)
  const atime = new Date(400)

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
    birthtime: birthtime,
    ctime: ctime,
    mtime: mtime,
    atime: atime,
    recursiveValue: recursiveValue,
    deepValue: deepValue
  }
}()
