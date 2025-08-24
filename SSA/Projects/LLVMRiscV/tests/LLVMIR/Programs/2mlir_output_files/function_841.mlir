module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 840 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
