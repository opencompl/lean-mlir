module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 81 : index} {
    %c-2852000999718258421_i64 = arith.constant -2852000999718258421 : i64
    %0 = arith.addi %c-2852000999718258421_i64, %arg0 overflow<nsw, nuw> : i64
    return %0 : i64
  }
}
