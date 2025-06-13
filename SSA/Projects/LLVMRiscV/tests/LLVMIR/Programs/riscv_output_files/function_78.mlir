module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 77 : index} {
    %false = arith.constant false
    %0 = arith.select %false, %arg0, %arg0 : i1
    return %0 : i1
  }
}
