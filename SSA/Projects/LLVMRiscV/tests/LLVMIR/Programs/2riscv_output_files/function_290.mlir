module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 289 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    return %1 : i64
  }
}
