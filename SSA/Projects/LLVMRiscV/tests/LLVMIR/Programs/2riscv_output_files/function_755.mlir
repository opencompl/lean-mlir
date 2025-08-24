module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 754 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
