module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 33 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg2 : i64
    return %1 : i64
  }
}
