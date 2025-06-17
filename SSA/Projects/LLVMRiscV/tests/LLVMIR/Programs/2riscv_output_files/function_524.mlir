module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 523 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
