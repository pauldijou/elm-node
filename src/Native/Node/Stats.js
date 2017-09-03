var _pauldijou$elm_node$Native_Node_Stats = function () {
  function isSomething(name) {
    return function (stats) {
      return stats[name]()
    }
  }

  function isSymbolicLink(stats) {
    if (typeof stats.isSymbolicLink === 'function') {
      return stats.isSymbolicLink()
    }
    return false
  }

  function getProperty(name) {
    return function (stats) {
      return stats[name]
    }
  }

  function toStringRadix(radix, value) {
    return value.toString(radix)
  }

  return {
    toStringRadix: F2(toStringRadix),
    isFile: isSomething('isFile'),
    isDirectory: isSomething('isDirectory'),
    isBlockDevice: isSomething('isBlockDevice'),
    isCharacterDevice: isSomething('isCharacterDevice'),
    isSymbolicLink: isSymbolicLink,
    isFIFO: isSomething('isFIFO'),
    isSocket: isSomething('isSocket'),
    dev: getProperty('dev'),
    ino: getProperty('ino'),
    mode: getProperty('mode'),
    nlink: getProperty('nlink'),
    uid: getProperty('uid'),
    gid: getProperty('gid'),
    rdev: getProperty('rdev'),
    size: getProperty('size'),
    blksize: getProperty('blksize'),
    blocks: getProperty('blocks'),
    atimeMs: getProperty('atimeMs'),
    mtimeMs: getProperty('mtimeMs'),
    ctimeMs: getProperty('ctimeMs'),
    birthtimeMs: getProperty('birthtimeMs'),
    atime: getProperty('atime'),
    mtime: getProperty('mtime'),
    ctime: getProperty('ctime'),
    birthtime: getProperty('birthtime')
  }
}()
