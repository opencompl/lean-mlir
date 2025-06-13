module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 191 : index} {
    %0 = arith.maxui %arg0, %arg1 : i1
    return %0 : i1
  }
}
