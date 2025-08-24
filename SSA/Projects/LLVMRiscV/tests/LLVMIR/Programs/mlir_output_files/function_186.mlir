module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 attributes {seed = 185 : index} {
    %0 = arith.floordivsi %arg1, %arg2 : i1
    %1 = arith.divsi %arg0, %0 : i1
    %true = arith.constant true
    %2 = arith.xori %arg2, %true : i1
    %3 = arith.floordivsi %1, %2 : i1
    return %3 : i1
  }
}
