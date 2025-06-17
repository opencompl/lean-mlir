module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 206 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %0, %0 : i64
    return %1 : i64
  }
}
