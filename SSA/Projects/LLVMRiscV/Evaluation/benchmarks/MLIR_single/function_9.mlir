module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.mul %arg0, %1 overflow<nuw> : i64
    %3 = llvm.icmp "ult" %0, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.zext %arg1 : i1 to i64
    %7 = llvm.and %1, %6 : i64
    %8 = llvm.sub %arg0, %7 overflow<nsw, nuw> : i64
    %9 = llvm.icmp "sgt" %5, %8 : i64
    return %9 : i1
  }
}
