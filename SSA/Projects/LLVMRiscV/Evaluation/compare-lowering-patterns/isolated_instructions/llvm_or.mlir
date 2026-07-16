// llvm.or
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    return %0 : i64
  }
}