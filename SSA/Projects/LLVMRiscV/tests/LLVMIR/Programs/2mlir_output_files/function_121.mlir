module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 120 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
