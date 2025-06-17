module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 800 : index} {
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
