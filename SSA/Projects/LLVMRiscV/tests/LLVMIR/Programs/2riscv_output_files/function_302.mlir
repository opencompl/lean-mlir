module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 301 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    return %1 : i64
  }
}
