module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 850 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
