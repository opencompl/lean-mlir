module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 916 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
