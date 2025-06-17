module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 977 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
