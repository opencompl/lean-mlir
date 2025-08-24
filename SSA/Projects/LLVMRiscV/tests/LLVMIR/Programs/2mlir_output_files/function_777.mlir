module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 776 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
