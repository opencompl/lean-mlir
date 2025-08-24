module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 938 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
