const _pauldijou$elm_node$Native_Node_FileSystem = function () {
  const fs = require('fs')
  const helpers = _pauldijou$elm_kernel_helpers$Native_Kernel_Helpers
  const parseError = _pauldijou$elm_error$Error$parse

  function normalize(value) {
    if (value === undefined || value === null) { return helpers.tuple.empty }
    if (Array.isArray(value)) { return helpers.list.fromArray(value) }
    return value
  }

  function taskify(fn) {
    return function taskified() {
      return helpers.task.fromCallback((succeed, fail) => {
        function callback(error, value1, value2) {
          if (error) {
            fail(parseError(error))
          } else if (value2 !== undefined) {
            succeed(helpers.tuple.pair(normalize(value1), normalize(value2)))
          } else {
            succeed(normalize(value1))
          }
        }

        try {
          fn(...arguments, callback)
        } catch (e) {
          fail(parseError(e))
        }
      })
    }
  }

  function resultify(fn) {
    return function resultified() {
      try {
        return helpers.result.ok(normalize(fn(...arguments)))
      } catch (error) {
        return helpers.result.err(parseError(error))
      }
    }
  }

  return {
    identity: function (a) { return a },
    access: F2(taskify(fs.access)),
    accessSync: F2(resultify(fs.accessSync)),
    appendFile: F3(taskify(fs.appendFile)),
    appendFileSync: F3(resultify(fs.appendFileSync)),
    chmod: F2(taskify(fs.chmod)),
    chmodSync: F2(resultify(fs.chmodSync)),
    chown: F3(taskify(fs.chown)),
    chownSync: F3(resultify(fs.chownSync)),
    close: taskify(fs.close),
    closeSync: resultify(fs.closeSync),
    createReadStream: F2(fs.createReadStream),
    createWriteStream: F2(fs.createWriteStream),
    fchmod: taskify(fs.fchmod),
    fchmodSync: resultify(fs.fchmodSync),
    fchown: F3(taskify(fs.fchown)),
    fchownSync: F3(resultify(fs.fchownSync)),
    fdatasync: taskify(fs.fdatasync),
    fdatasyncSync: resultify(fs.fdatasyncSync),
    fstat: taskify(fs.fstat),
    fstatSync: resultify(fs.fstatSync),
    fsync: taskify(fs.fsync),
    fsyncSync: resultify(fs.fsyncSync),
    ftruncate: F2(taskify(fs.ftruncate)),
    ftruncateSync: F2(resultify(fs.ftruncateSync)),
    futimes: F3(taskify(fs.futimes)),
    futimesSync: F3(resultify(fs.futimesSync)),
    // Only available on macOS.
    // lchmod: F2(taskify(fs.lchmod)),
    // lchmodSync: F2(resultify(fs.lchmodSync)),
    lchown: F3(taskify(fs.lchown)),
    lchownSync: F3(resultify(fs.lchownSync)),
    link: F2(taskify(fs.link)),
    linkSync: F2(resultify(fs.linkSync)),
    lstat: taskify(fs.lstat),
    lstatSync: resultify(fs.lstatSync),
    mkdir: F2(taskify(fs.mkdir)),
    mkdirSync: F2(resultify(fs.mkdirSync)),
    mkdtemp: F2(taskify(fs.mkdtemp)),
    mkdtempSync: F2(resultify(fs.mkdtempSync)),
    open: F3(taskify(fs.open)),
    openSync: F3(resultify(fs.openSync)),
    read: F5(taskify(fs.read)),
    readSync: F5(resultify(fs.readSync)),
    readdir: F2(taskify(fs.readdir)),
    readdirSync: F2(resultify(fs.readdirSync)),
    readFile: F2(taskify(fs.readFile)),
    readFileSync: F2(resultify(fs.readFileSync)),
    readlink: F2(taskify(fs.readlink)),
    readlinkSync: F2(resultify(fs.readlinkSync)),
    realpath: taskify(fs.realpath),
    realpathSync: resultify(fs.realpathSync),
    rename: F2(taskify(fs.rename)),
    renameSync: F2(resultify(fs.renameSync)),
    rmdir: taskify(fs.rmdir),
    rmdirSync: resultify(fs.rmdirSync),
    stat: taskify(fs.stat),
    statSync: resultify(fs.statSync),
    symlink: F3(taskify(fs.symlink)),
    symlinkSync: F3(resultify(fs.symlinkSync)),
    truncate: F2(taskify(fs.truncate)),
    truncateSync: F2(resultify(fs.truncateSync)),
    unlink: taskify(fs.unlink),
    unlinkSync: resultify(fs.unlinkSync),
    // unwatchFile: F2(taskify(fs.unwatchFile)),
    utimes: F3(taskify(fs.utimes)),
    utimesSync: F3(resultify(fs.utimesSync)),
    // watch: F3(taskify(fs.watch)),
    // watchFile: F3(taskify(fs.watchFile)),
    writeBuffer: F5(taskify(fs.write)),
    writeBufferSync: F3(resultify(fs.writeFileSync)),
    writeString: F4(taskify(fs.write)),
    writeStringSync: F3(resultify(fs.writeFileSync)),
    writeFile: F3(taskify(fs.writeFile)),
    writeFileSync: F3(resultify(fs.writeFileSync)),
    'F_OK': fs.constants.F_OK,
    'R_OK': fs.constants.R_OK,
    'W_OK': fs.constants.W_OK,
    'X_OK': fs.constants.X_OK,
    'O_RDONLY': fs.constants.O_RDONLY,
    'O_WRONLY': fs.constants.O_WRONLY,
    'O_RDWR': fs.constants.O_RDWR,
    'O_CREAT': fs.constants.O_CREAT,
    'O_EXCL': fs.constants.O_EXCL,
    'O_NOCTTY': fs.constants.O_NOCTTY,
    'O_TRUNC': fs.constants.O_TRUNC,
    'O_APPEND': fs.constants.O_APPEND,
    'O_DIRECTORY': fs.constants.O_DIRECTORY,
    'O_NOATIME': fs.constants.O_NOATIME,
    'O_NOFOLLOW': fs.constants.O_NOFOLLOW,
    'O_SYNC': fs.constants.O_SYNC,
    'O_SYMLINK': fs.constants.O_SYMLINK,
    'O_DIRECT': fs.constants.O_DIRECT,
    'O_NONBLOCK': fs.constants.O_NONBLOCK,
    'S_IFMT': fs.constants.S_IFMT,
    'S_IFREG': fs.constants.S_IFREG,
    'S_IFCHR': fs.constants.S_IFCHR,
    'S_IFBLK': fs.constants.S_IFBLK,
    'S_IFIFO': fs.constants.S_IFIFO,
    'S_IFLNK': fs.constants.S_IFLNK,
    'S_IFSOCK': fs.constants.S_IFSOCK,
    'S_IRWXU': fs.constants.S_IRWXU,
    'S_IRUSR': fs.constants.S_IRUSR,
    'S_IWUSR': fs.constants.S_IWUSR,
    'S_IXUSR': fs.constants.S_IXUSR,
    'S_IRWXG': fs.constants.S_IRWXG,
    'S_IRGRP': fs.constants.S_IRGRP,
    'S_IWGRP': fs.constants.S_IWGRP,
    'S_IXGRP': fs.constants.S_IXGRP,
    'S_IRWXO': fs.constants.S_IRWXO,
    'S_IROTH': fs.constants.S_IROTH,
    'S_IWOTH': fs.constants.S_IWOTH,
    'S_IXOTH': fs.constants.S_IXOTH,
  }
}()
