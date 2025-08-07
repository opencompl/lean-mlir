module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 79 : index} {
    %c2026955581972156870_i64 = arith.constant 2026955581972156870 : i64
    %0 = arith.andi %c2026955581972156870_i64, %arg0 : i64
    %1 = arith.floordivsi %0, %arg1 : i64
    return %1 : i64
  }
}
