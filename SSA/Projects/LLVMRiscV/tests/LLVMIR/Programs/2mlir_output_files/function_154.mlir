module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 153 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.add %0, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
