module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 204 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
