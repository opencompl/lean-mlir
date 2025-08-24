module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 18 : index} {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
