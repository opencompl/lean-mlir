module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 374 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
