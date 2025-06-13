module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 11 : index} {
    %0 = arith.divsi %arg0, %arg0 : i64
    %1 = arith.minsi %0, %0 : i64
    return %1 : i64
  }
}
