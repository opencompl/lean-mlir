module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 117 : index} {
    %0 = arith.remsi %arg0, %arg1 : i64
    %1 = arith.addi %0, %arg0 overflow<nsw> : i64
    return %1 : i64
  }
}
