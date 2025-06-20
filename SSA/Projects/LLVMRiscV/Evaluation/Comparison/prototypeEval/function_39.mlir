module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 94 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    return %1 : i1
  }
}
