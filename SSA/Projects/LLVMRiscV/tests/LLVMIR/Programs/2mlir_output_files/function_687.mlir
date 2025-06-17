module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 686 : index} {
    %0 = llvm.udiv %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
