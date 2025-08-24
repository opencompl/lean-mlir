module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 197 : index} {
    %c-1629065603047637383_i64 = arith.constant -1629065603047637383 : i64
    %c-382332001542543107_i64 = arith.constant -382332001542543107 : i64
    %0 = arith.select %arg1, %c-382332001542543107_i64, %arg0 : i64
    %1 = arith.minsi %arg0, %0 : i64
    %2 = arith.ceildivui %c-1629065603047637383_i64, %1 : i64
    return %2 : i64
  }
}
