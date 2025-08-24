module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 592 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
