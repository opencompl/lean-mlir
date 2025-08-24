module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 687 : index} {
    %0 = llvm.urem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
