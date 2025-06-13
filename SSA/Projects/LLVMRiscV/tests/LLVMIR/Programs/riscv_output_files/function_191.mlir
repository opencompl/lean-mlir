module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 190 : index} {
    %true = arith.constant true
    %0 = arith.maxui %true, %arg0 : i1
    %1 = arith.maxsi %0, %arg1 : i1
    return %1 : i1
  }
}
