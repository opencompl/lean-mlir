module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 13 : index} {
    %0 = arith.xori %arg0, %arg0 : i1
    return %0 : i1
  }
}
