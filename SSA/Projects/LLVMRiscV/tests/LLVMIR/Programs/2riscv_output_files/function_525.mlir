module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 524 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
