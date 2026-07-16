// llvm.select
module {
  func.func @main(%cond : i1, %arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.select %cond, %arg0, %arg1 : i1, i64
    return %0 : i64
  }
}