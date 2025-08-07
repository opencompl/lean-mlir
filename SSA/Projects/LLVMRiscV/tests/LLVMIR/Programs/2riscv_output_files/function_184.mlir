module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 183 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    return %1 : i64
  }
}
