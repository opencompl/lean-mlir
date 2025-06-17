module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 960 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
