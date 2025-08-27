module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.sub %arg1, %arg1 overflow<nsw, nuw> : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %arg2, %arg1, %arg0 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.ashr %3, %1 : i64
    %6 = llvm.add %3, %5 overflow<nsw> : i64
    %7 = llvm.icmp "sle" %4, %6 : i64
    %8 = llvm.trunc %7 : i1 to i64
    %9 = llvm.shl %2, %8 overflow<nsw, nuw> : i64
    return %9 : i64
  }
}
