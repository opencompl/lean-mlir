module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 121 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
