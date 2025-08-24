module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 21 : index} {
    %c-6542139666827468300_i64 = arith.constant -6542139666827468300 : i64
    %0 = arith.addi %c-6542139666827468300_i64, %arg0 : i64
    return %0 : i64
  }
}
