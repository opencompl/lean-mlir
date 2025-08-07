module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 160 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
