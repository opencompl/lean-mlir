module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 73 : index} {
    %c7916645702478358597_i64 = arith.constant 7916645702478358597 : i64
    %0 = arith.maxsi %c7916645702478358597_i64, %arg0 : i64
    return %0 : i64
  }
}
