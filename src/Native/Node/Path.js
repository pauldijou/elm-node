const _pauldijou$elm_node$Native_Node_Path = function () {
  const path = require('path')

  function basename(p) {
    return path.basename(p)
  }

  function basenameExt(ext, p) {
    return path.basename(p, ext)
  }

  function join(paths) {
    return path.join.apply(path, paths)
  }

  function resolve(paths) {
    return path.resolve.apply(path, paths)
  }

  return {
    basename: basename,
    basenameExt: F2(basenameExt),
    delimiter: path.delimiter,
    dirname: path.dirname,
    extname: path.extname,
    format: path.format,
    isAbsolute: path.isAbsolute,
    join: join,
    normalize: path.normalize,
    parse: path.parse,
    relative: F2(path.relative),
    resolve: resolve,
    sep: path.sep
  }
}()
