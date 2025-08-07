module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 attributes {seed = 27 : index} {
    %false = arith.constant false
    %0 = arith.andi %arg0, %false : i1
    %1 = arith.remsi %0, %arg0 : i1
    %2 = arith.addi %arg1, %arg2 overflow<nuw> : i1
    %3 = arith.maxui %1, %2 : i1
    return %3 : i1
  }
}
