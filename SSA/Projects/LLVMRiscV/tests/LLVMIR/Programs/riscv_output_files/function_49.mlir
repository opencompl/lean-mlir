module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 48 : index} {
    %false = arith.constant false
    %0 = arith.remui %false, %arg0 : i1
    return %0 : i1
  }
}
