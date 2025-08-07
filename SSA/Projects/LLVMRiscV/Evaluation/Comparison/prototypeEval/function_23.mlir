module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 49 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.trunc %1 overflow<nsw> : i64 to i1
    return %2 : i1
  }
}
