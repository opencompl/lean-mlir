module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 720 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
