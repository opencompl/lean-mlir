module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 119 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
