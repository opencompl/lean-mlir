module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 7 : index} {
    %0 = arith.andi %arg0, %arg0 : i64
    return %0 : i64
  }
}
