module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 350 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
