module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 567 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
