module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 542 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
