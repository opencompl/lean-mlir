module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 945 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
