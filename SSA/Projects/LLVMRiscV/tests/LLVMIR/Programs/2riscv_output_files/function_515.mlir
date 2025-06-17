module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 514 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
