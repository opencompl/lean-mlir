module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 attributes {seed = 31 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.shl %1, %0 overflow<nuw> : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.mul %0, %3 overflow<nuw> : i64
    return %4 : i64
  }
}
