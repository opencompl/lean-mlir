module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 770 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
