module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 286 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
