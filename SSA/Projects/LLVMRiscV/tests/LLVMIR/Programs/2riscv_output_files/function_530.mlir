module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 529 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
