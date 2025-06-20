module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 99 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
