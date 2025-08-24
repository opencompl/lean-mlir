module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 600 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
