module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 82 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    return %2 : i64
  }
}
