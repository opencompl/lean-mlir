module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 71 : index} {
    %0 = arith.select %arg0, %arg1, %arg1 : i64
    return %0 : i64
  }
}
