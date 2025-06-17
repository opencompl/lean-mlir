module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 144 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
