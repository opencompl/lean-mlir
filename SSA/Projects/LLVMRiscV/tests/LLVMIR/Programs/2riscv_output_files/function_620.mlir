module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 619 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
