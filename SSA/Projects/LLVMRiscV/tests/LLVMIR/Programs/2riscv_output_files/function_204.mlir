module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 203 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.or %0, %arg0 : i64
    return %1 : i64
  }
}
