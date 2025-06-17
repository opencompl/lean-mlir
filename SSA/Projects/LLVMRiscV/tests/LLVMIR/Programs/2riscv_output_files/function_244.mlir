module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 243 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %0, %0 : i64
    return %1 : i64
  }
}
