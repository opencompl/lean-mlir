module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 103 : index} {
    %c-1134788058768042145_i64 = arith.constant -1134788058768042145 : i64
    %0 = arith.remui %arg0, %arg0 : i64
    %1 = arith.ceildivsi %arg0, %0 : i64
    %2 = arith.xori %c-1134788058768042145_i64, %1 : i64
    return %2 : i64
  }
}
