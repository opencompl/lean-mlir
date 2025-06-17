module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 225 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
