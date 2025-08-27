module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    %5 = llvm.zext %3 : i1 to i64
    %6 = llvm.icmp "ult" %5, %arg1 : i64
    %7 = llvm.sext %6 : i1 to i64
    %8 = llvm.add %arg1, %7 overflow<nsw, nuw> : i64
    %9 = llvm.icmp "sgt" %4, %8 : i64
    return %9 : i1
  }
}
