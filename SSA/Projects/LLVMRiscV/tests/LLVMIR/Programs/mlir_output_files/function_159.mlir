module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 attributes {seed = 158 : index} {
    %true = arith.constant true
    %0 = arith.divsi %arg0, %true : i1
    %1 = arith.divsi %arg0, %arg1 : i1
    %2 = arith.maxsi %0, %1 : i1
    %3 = arith.extui %2 : i1 to i64
    %4 = arith.cmpi ule, %3, %arg2 : i64
    return %4 : i1
  }
}
