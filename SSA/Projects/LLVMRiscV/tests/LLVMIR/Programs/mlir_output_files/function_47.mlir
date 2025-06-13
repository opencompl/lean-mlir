module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 46 : index} {
    %0 = arith.trunci %arg0 : i64 to i1
    return %0 : i1
  }
}
