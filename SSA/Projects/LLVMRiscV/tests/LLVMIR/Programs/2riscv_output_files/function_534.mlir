module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 533 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
