module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 25 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
