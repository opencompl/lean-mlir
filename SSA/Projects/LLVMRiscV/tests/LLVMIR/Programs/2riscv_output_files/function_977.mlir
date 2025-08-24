module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 976 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
