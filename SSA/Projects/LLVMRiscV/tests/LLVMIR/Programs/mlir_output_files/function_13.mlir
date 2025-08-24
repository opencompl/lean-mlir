module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 12 : index} {
    %0 = arith.minsi %arg0, %arg1 : i64
    %1 = arith.remsi %0, %arg1 : i64
    %c-2293592565771025543_i64 = arith.constant -2293592565771025543 : i64
    %2 = arith.ceildivsi %c-2293592565771025543_i64, %arg2 : i64
    %3 = arith.divsi %1, %2 : i64
    return %3 : i64
  }
}
