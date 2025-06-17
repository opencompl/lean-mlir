module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 578 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
