; 136 649 programs
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 attributes {seed = 0 : index} {
    %0 = arith.maxui %arg0, %arg0 : i1
    %false = arith.constant false
    %1 = arith.minui %arg2, %false : i1
    %2 = arith.divui %arg1, %1 : i1
    %3 = arith.ceildivui %0, %2 : i1
    %4 = arith.ceildivsi %arg2, %2 : i1
    %5 = arith.shrui %3, %4 : i1
    return %5 : i1
  }
}
