module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 147 : index} {
    %c1709762404545841349_i64 = arith.constant 1709762404545841349 : i64
    %0 = arith.minui %arg0, %arg0 : i64
    %1 = arith.andi %c1709762404545841349_i64, %0 : i64
    return %1 : i64
  }
}
