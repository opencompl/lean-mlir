module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 36 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
