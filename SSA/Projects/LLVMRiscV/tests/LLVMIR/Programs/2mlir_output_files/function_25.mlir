module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 24 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
