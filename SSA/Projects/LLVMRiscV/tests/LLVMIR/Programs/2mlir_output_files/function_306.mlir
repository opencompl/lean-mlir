module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 305 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.shl %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
