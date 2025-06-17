module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 758 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
