module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 276 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg0 : i64
    return %1 : i64
  }
}
