module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 821 : index} {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
