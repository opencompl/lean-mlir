module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 attributes {seed = 92 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %1 overflow<nsw> : i64 to i1
    return %2 : i1
  }
}
