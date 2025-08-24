module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 772 : index} {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
