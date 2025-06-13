module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 15 : index} {
    %0 = arith.minsi %arg0, %arg0 : i64
    %1 = arith.muli %arg1, %arg0 : i64
    %2 = arith.shli %0, %1 : i64
    return %2 : i64
  }
}
