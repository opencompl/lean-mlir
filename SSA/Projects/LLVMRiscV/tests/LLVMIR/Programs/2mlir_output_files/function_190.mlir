module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 189 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.or %0, %arg1 {isDisjointFlag} : i64
    return %1 : i64
  }
}
