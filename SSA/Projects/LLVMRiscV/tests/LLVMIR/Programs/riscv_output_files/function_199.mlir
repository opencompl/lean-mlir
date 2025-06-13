module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 198 : index} {
    %c-1942878423542849690_i64 = arith.constant -1942878423542849690 : i64
    %0 = arith.subi %c-1942878423542849690_i64, %arg0 : i64
    %1 = arith.shrui %0, %arg1 : i64
    return %1 : i64
  }
}
