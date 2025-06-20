module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 4 : index} {
    %0 = llvm.mul %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
