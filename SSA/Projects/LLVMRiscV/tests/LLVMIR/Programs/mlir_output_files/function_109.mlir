module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 108 : index} {
    %0 = arith.maxsi %arg0, %arg0 : i1
    return %0 : i1
  }
}
