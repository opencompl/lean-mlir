module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 180 : index} {
    %c6061852734527939001_i64 = arith.constant 6061852734527939001 : i64
    %c-1887855366840786876_i64 = arith.constant -1887855366840786876 : i64
    %0 = arith.remsi %c6061852734527939001_i64, %c-1887855366840786876_i64 : i64
    %1 = arith.minsi %0, %arg0 : i64
    %2 = arith.muli %1, %arg1 : i64
    return %2 : i64
  }
}
