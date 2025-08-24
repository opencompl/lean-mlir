module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 636 : index} {
    %0 = llvm.srem %arg1, %arg0 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
