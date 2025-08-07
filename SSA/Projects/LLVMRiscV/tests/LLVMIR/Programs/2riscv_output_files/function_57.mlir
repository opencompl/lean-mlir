module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 56 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
