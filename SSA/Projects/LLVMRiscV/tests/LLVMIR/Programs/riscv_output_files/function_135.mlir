module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 attributes {seed = 134 : index} {
    %0 = arith.divsi %arg0, %arg0 : i1
    %1 = arith.ceildivui %0, %arg1 : i1
    %false = arith.constant false
    %true = arith.constant true
    %2 = arith.subi %true, %arg1 : i1
    %3 = arith.ceildivui %false, %2 : i1
    %4 = arith.addi %1, %3 overflow<nsw> : i1
    return %4 : i1
  }
}
