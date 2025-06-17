module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 926 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
