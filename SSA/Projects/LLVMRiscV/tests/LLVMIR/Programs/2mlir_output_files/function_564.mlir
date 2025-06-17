module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 563 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
