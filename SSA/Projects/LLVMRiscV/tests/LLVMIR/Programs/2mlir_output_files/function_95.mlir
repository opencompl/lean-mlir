module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 94 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
