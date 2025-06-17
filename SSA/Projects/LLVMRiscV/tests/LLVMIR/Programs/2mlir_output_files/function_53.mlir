module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 52 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
