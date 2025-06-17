module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 109 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.mul %0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
