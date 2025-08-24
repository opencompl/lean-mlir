module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 666 : index} {
    %0 = llvm.urem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
