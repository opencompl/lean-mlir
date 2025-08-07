module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 55 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
