module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 756 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
