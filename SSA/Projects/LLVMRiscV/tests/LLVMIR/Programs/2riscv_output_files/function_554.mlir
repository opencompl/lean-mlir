module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 553 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    return %1 : i1
  }
}
