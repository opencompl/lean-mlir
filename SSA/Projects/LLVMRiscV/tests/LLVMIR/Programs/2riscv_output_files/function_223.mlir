module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 222 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
