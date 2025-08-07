module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 133 : index} {
    %0 = arith.muli %arg0, %arg0 : i1
    %1 = arith.addi %0, %0 : i1
    return %1 : i1
  }
}
