module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 360 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %0 : i64
  }
}
