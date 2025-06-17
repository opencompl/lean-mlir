module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 405 : index} {
    %0 = llvm.sub %arg1, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
