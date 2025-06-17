module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 652 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
