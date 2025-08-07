module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 697 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
