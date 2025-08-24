module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 151 : index} {
    %c-2922715212673609339_i64 = arith.constant -2922715212673609339 : i64
    %0 = arith.divsi %c-2922715212673609339_i64, %arg0 : i64
    %1 = arith.remsi %0, %arg0 : i64
    return %1 : i64
  }
}
