module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 262 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg0 : i64
    return %1 : i64
  }
}
