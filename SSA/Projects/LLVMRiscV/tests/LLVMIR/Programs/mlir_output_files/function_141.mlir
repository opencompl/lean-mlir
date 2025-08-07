module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 140 : index} {
    %false = arith.constant false
    %0 = arith.ori %false, %arg0 : i1
    return %0 : i1
  }
}
