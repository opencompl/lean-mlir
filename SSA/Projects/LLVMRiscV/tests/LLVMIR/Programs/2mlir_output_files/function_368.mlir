module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 367 : index} {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
