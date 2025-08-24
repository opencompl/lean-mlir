module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 240 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %0, %arg1 : i64
    return %1 : i64
  }
}
