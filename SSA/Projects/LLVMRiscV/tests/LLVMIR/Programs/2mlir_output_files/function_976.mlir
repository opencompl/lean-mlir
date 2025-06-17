module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 975 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
