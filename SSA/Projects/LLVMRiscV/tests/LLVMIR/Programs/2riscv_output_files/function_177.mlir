module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 176 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    return %1 : i64
  }
}
