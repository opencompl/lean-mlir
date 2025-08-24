module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 157 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    return %1 : i64
  }
}
