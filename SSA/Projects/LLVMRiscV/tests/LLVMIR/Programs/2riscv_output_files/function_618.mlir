module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 617 : index} {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
