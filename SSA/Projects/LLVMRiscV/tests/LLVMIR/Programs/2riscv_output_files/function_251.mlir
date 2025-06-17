module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 250 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sub %0, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
