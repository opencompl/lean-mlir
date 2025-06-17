module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 318 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
