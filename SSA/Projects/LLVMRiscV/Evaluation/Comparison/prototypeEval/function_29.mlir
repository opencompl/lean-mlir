module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 69 : index} {
    %0 = llvm.trunc %arg0 : i64 to i1
    return %0 : i1
  }
}
