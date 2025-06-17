module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 73 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    return %1 : i64
  }
}
