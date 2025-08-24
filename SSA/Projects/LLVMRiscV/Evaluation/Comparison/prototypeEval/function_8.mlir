module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 17 : index} {
    %0 = llvm.trunc %arg0 overflow<nsw> : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    return %1 : i64
  }
}
