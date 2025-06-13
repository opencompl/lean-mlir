module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 199 : index} {
    %0 = arith.minui %arg0, %arg0 : i64
    %c5185231879317400701_i64 = arith.constant 5185231879317400701 : i64
    %1 = arith.divui %arg1, %c5185231879317400701_i64 : i64
    %2 = arith.xori %0, %1 : i64
    %3 = arith.minui %2, %1 : i64
    return %3 : i64
  }
}
