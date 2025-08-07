module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 158 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
