module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 950 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
