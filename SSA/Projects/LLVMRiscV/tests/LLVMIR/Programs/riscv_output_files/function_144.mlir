module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 143 : index} {
    %false = arith.constant false
    %0 = arith.remsi %false, %arg0 : i1
    return %0 : i1
  }
}
