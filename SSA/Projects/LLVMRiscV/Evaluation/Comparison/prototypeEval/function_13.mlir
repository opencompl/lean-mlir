module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 26 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
