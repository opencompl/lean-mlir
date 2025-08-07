module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 579 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
