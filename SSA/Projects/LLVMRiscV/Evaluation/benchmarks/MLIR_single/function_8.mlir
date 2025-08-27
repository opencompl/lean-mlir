module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.urem %arg2, %1 : i64
    %5 = llvm.sext %arg1 : i1 to i64
    %6 = llvm.lshr %5, %1 : i64
    %7 = llvm.add %arg0, %6 overflow<nsw, nuw> : i64
    %8 = llvm.udiv %4, %7 : i64
    %9 = llvm.icmp "ugt" %3, %8 : i64
    return %9 : i1
  }
}
