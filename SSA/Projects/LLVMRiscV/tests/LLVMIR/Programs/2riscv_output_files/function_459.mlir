module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 458 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
