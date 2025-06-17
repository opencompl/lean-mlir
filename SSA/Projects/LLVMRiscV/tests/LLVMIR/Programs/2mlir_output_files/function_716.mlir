module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 715 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
