module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 88 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 overflow<nuw> : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
