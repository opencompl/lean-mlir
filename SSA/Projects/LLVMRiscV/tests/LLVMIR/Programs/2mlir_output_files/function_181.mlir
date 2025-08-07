module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 180 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
