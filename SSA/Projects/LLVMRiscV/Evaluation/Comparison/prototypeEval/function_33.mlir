module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 83 : index} {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw> : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
