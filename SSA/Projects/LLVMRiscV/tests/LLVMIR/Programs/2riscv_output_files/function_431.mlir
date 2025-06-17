module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 430 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
