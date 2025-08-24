module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 138 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
