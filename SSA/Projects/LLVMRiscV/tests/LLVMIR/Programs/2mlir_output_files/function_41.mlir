module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 40 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
