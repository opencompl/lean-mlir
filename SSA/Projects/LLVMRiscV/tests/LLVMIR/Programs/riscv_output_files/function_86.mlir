module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 85 : index} {
    %c-4171462070785885032_i64 = arith.constant -4171462070785885032 : i64
    %0 = arith.muli %c-4171462070785885032_i64, %arg0 : i64
    return %0 : i64
  }
}
