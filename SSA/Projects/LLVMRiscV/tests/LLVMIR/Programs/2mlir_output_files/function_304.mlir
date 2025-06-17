module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 303 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
