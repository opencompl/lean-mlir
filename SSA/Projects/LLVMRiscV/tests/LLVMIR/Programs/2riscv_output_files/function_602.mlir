module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 601 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
