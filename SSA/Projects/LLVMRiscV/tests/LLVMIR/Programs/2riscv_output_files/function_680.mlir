module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 679 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
