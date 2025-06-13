module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 102 : index} {
    %0 = arith.extui %arg1 : i1 to i64
    %1 = arith.floordivsi %arg0, %0 : i64
    return %1 : i64
  }
}
