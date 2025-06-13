module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 6 : index} {
    %true = arith.constant true
    %0 = arith.floordivsi %arg0, %arg0 : i1
    %1 = arith.maxsi %true, %0 : i1
    return %1 : i1
  }
}
