module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 558 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
