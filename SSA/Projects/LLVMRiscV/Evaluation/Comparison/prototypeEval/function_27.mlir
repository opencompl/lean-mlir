module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 65 : index} {
    %0 = llvm.mul %arg0, %arg0 overflow<nsw, nuw> : i64
    return %0 : i64
  }
}
