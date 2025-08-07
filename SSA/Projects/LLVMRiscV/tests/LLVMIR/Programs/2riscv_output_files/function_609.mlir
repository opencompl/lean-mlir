module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 608 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
