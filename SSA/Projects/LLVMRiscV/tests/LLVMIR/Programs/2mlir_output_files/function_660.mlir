module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 659 : index} {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
