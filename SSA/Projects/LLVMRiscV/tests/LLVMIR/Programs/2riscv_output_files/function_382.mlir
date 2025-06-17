module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 381 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
