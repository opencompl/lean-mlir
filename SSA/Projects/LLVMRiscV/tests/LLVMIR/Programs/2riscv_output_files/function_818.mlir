module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 817 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
