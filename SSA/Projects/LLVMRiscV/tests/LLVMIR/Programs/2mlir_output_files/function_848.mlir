module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 847 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
