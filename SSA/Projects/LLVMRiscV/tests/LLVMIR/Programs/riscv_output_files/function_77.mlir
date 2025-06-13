module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 76 : index} {
    %c-8029593728665262052_i64 = arith.constant -8029593728665262052 : i64
    %0 = arith.maxsi %arg0, %c-8029593728665262052_i64 : i64
    %1 = arith.maxui %0, %arg1 : i64
    return %1 : i64
  }
}
