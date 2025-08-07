module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 99 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
