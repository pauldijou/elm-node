const _pauldijou$elm_node$Native_Node_FileSystem = function () {
  const fs = require('fs')
  const helpers = _pauldijou$elm_kernel_helpers$Native_Kernel_Helpers
  const parseError = _pauldijou$elm_error$Error$parse

  function taskify(fn) {
    return function taskified() {
      return helpers.task.fromCallback((succeed, fail) => {
        function callback(error, value) {
          if (error !== undefined) {
            fail(parseError(error))
          } else {
            succeed(value === undefined ? helpers.tuple.empty : value)
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
        return helpers.result.ok(fn(...arguments))
      } catch (error) {
        return helpers.result.err(parseError(error))
      }
    }
  }

  return {
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
    lchmod: F2(taskify(fs.lchmod)),
    lchmodSync: F2(resultify(fs.lchmodSync)),
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
    'F_OK': fs.F_OK,
    'R_OK': fs.R_OK,
    'W_OK': fs.W_OK,
    'X_OK': fs.X_OK,
    'O_RDONLY': fs.O_RDONLY,
    'O_WRONLY': fs.O_WRONLY,
    'O_RDWR': fs.O_RDWR,
    'O_CREAT': fs.O_CREAT,
    'O_EXCL': fs.O_EXCL,
    'O_NOCTTY': fs.O_NOCTTY,
    'O_TRUNC': fs.O_TRUNC,
    'O_APPEND': fs.O_APPEND,
    'O_DIRECTORY': fs.O_DIRECTORY,
    'O_NOATIME': fs.O_NOATIME,
    'O_NOFOLLOW': fs.O_NOFOLLOW,
    'O_SYNC': fs.O_SYNC,
    'O_SYMLINK': fs.O_SYMLINK,
    'O_DIRECT': fs.O_DIRECT,
    'O_NONBLOCK': fs.O_NONBLOCK,
    'S_IFMT': fs.S_IFMT,
    'S_IFREG': fs.S_IFREG,
    'S_IFCHR': fs.S_IFCHR,
    'S_IFBLK': fs.S_IFBLK,
    'S_IFIFO': fs.S_IFIFO,
    'S_IFLNK': fs.S_IFLNK,
    'S_IFSOCK': fs.S_IFSOCK,
    'S_IRWXU': fs.S_IRWXU,
    'S_IRUSR': fs.S_IRUSR,
    'S_IWUSR': fs.S_IWUSR,
    'S_IXUSR': fs.S_IXUSR,
    'S_IRWXG': fs.S_IRWXG,
    'S_IRGRP': fs.S_IRGRP,
    'S_IWGRP': fs.S_IWGRP,
    'S_IXGRP': fs.S_IXGRP,
    'S_IRWXO': fs.S_IRWXO,
    'S_IROTH': fs.S_IROTH,
    'S_IWOTH': fs.S_IWOTH,
    'S_IXOTH': fs.S_IXOTH,
  }
}()
