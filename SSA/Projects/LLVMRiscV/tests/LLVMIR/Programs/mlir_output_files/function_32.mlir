module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 31 : index} {
    %0 = arith.select %arg0, %arg0, %arg0 : i1
    return %0 : i1
  }
}
