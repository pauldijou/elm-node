var _pauldijou$elm_node$Native_Node_Test_Helpers = function () {
  var recursiveValue = { a: 1 }
  recursiveValue.b = recursiveValue

  var deepValue = { next: { next: { next: { done: true }}}}

  return {
    recursiveValue: recursiveValue,
    deepValue: deepValue
  }
}()
