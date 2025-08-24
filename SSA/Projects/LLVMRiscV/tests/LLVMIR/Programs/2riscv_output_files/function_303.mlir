module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 302 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
