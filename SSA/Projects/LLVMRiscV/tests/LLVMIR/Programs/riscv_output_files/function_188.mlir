module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 187 : index} {
    %0 = arith.shrui %arg0, %arg1 : i1
    %1 = arith.maxui %arg0, %0 : i1
    return %1 : i1
  }
}
