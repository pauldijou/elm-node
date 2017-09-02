var _pauldijou$elm_node$Native_Node_Buffer = function () {
  const buffer = require('buffer')
  const Buffer = require('buffer').Buffer
  const helpers = _pauldijou$elm_kernel_helpers$Native_Kernel_Helpers

  function compareRange(value1, value2) {
    return value1.buffer.compare(value2.buffer, value2.start, value2.end, value1.start, value2.end)
  }

  function concat(bufs) {
    return Buffer.concat(helpers.list.toArray(bufs))
  }

  function concat2(bufs, totalLength) {
    return Buffer.concat(helpers.list.toArray(bufs), totalLength)
  }

  function poolSize() {
    return helpers.task.fromCallback(succeed => succeed(Buffer.poolSize))
  }

  function setPoolSize(value) {
    return helpers.task.fromCallback(succeed => {
      Buffer.poolSize = value
      succeed(Buffer.poolSize)
    })
  }

  function copy(params) {
    return params.source.copy(Buffer.from(params.target), params.targetStart, params.sourceStart, params.sourceEnd)
  }

  function copyTo(target, source) {
    return source.copy(Buffer.from(target))
  }

  function equals(b1, b2) {
    return b1.equals(b2)
  }

  function fill(value, buf) { return buf.fill(value) }
  function fill2(value, offset, buf) { return buf.fill(value, offset) }
  function fill3(value, offset, end, buf) { return buf.fill(value, offset, end) }
  function fill4(value, offset, end, enc, buf) { return buf.fill(value, offset, end, enc) }

  function includes(value, buf) { return buf.includes(value) }
  function includes2(value, byteOffset, buf) { return buf.includes(value, byteOffset) }
  function includes3(value, byteOffset, enc, buf) { return buf.includes(value, byteOffset, enc) }

  function indexOf(value, buf) { return buf.indexOf(value) }
  function indexOf2(value, byteOffset, buf) { return buf.indexOf(value, byteOffset) }
  function indexOf3(value, byteOffset, enc, buf) { return buf.indexOf(value, byteOffset, enc) }

  function lastIndexOf(value, buf) { return buf.lastIndexOf(value) }
  function lastIndexOf2(value, byteOffset, buf) { return buf.lastIndexOf(value, byteOffset) }
  function lastIndexOf3(value, byteOffset, enc, buf) { return buf.lastIndexOf(value, byteOffset, enc) }

  function length(buf) { return buf.length }

  function slice(buf) { return buf.slice() }
  function slice2(start, buf) { return buf.slice(start) }
  function slice3(start, end, buf) { return buf.slice(start, end) }

  function toJSON(buf) { return buf.toJSON() }

  function stringify(buf) { return buf.toString() }
  function stringify2(enc, buf) { return buf.toString(enc) }
  function stringify3(enc, start, buf) { return buf.toString(enc, start) }
  function stringify4(enc, start, end, buf) { return buf.toString(enc, start, end) }

  function transcode(fromEnc, toEnc, buf) { return buffer.transcode(buf, fromEnc, toEnc) }

  const constants = buffer.constants || {
    'MAX_LENGTH': buffer.kMaxLength,
    'MAX_STRING_LENGTH': 0
  }

  return {
    alloc: F2(Buffer.alloc),
    allocUnsafe: Buffer.allocUnsafe,
    allocUnsafeSlow: Buffer.allocUnsafeSlow,
    byteLength: F2(Buffer.byteLength),
    compare: F2(Buffer.compare),
    compareRange: F2(compareRange),
    concat: concat,
    concat2: F2(concat2),
    fromBuffer: Buffer.from,
    fromString: F2(Buffer.from),
    isEncoding: F2(Buffer.isEncoding),
    poolSize: poolSize,
    setPoolSize: setPoolSize,
    copy: copy,
    copyTo: F2(copyTo),
    equals: equals,
    fill: F2(fill),
    fill2: F3(fill2),
    fill3: F4(fill3),
    fill4: F5(fill4),
    includes: F2(includes),
    includes2: F3(includes2),
    includes3: F4(includes3),
    indexOf: F2(indexOf),
    indexOf2: F3(indexOf2),
    indexOf3: F4(indexOf3),
    lastIndexOf: F2(lastIndexOf),
    lastIndexOf2: F3(lastIndexOf2),
    lastIndexOf3: F4(lastIndexOf3),
    length: length,
    slice: slice,
    slice2: F2(slice2),
    slice3: F3(slice3),
    toJSON: toJSON,
    stringify: stringify,
    stringify2: F2(stringify2),
    stringify3: F3(stringify3),
    stringify4: F4(stringify4),
    maxLength: constants.MAX_LENGTH,
    maxStringLength: constants.MAX_STRING_LENGTH,
    inspectMaxBytes: buffer.INSPECT_MAX_BYTES
  }
}()
