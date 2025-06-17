module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 879 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
