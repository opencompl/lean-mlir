module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 925 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
