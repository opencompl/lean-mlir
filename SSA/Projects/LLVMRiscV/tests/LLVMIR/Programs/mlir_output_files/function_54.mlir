module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 53 : index} {
    %0 = arith.shli %arg0, %arg1 : i1
    %true = arith.constant true
    %true_0 = arith.constant true
    %1 = arith.shrui %true, %true_0 : i1
    %2 = arith.ori %0, %1 : i1
    return %2 : i1
  }
}
