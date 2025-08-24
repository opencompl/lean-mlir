module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 40 : index} {
    %0 = llvm.mul %arg0, %arg0 overflow<nuw> : i64
    %1 = llvm.urem %0, %arg1 : i64
    return %1 : i64
  }
}
