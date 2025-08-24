module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 473 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
