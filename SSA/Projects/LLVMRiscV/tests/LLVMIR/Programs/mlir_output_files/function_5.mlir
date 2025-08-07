module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 4 : index} {
    %0 = arith.addi %arg0, %arg0 overflow<nsw, nuw> : i64
    %1 = arith.remui %0, %arg0 : i64
    return %1 : i64
  }
}
