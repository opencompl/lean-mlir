module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 33 : index} {
    return %arg0 : i1
  }
}
