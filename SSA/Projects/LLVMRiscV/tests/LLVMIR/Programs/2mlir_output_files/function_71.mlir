module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 70 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
