module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 122 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
