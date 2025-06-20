module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 89 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
