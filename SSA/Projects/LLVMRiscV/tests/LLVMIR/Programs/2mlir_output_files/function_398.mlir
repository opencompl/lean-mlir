module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 397 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
