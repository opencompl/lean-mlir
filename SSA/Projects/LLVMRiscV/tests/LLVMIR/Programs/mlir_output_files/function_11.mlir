module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 attributes {seed = 10 : index} {
    %false = arith.constant false
    %false_0 = arith.constant false
    %0 = arith.shrui %false, %false_0 : i1
    %1 = arith.andi %0, %arg0 : i1
    %false_1 = arith.constant false
    %2 = arith.remui %arg2, %false_1 : i1
    %3 = arith.shrui %arg1, %2 : i1
    %4 = arith.shrsi %1, %3 : i1
    return %4 : i1
  }
}
