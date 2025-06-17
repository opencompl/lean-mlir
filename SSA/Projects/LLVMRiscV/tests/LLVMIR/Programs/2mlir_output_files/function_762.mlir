module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 761 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
