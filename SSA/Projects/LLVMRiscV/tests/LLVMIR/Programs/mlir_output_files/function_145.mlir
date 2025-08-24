module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 144 : index} {
    %true = arith.constant true
    %0 = arith.select %arg0, %arg0, %arg0 : i1
    %1 = arith.maxsi %arg0, %0 : i1
    %2 = arith.shrui %arg0, %1 : i1
    %3 = arith.shrsi %true, %2 : i1
    %4 = arith.xori %3, %arg0 : i1
    return %4 : i1
  }
}
