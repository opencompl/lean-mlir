module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 216 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
