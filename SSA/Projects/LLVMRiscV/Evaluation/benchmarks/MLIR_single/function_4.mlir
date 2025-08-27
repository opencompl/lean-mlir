module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.add %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.mul %0, %1 : i64
    %3 = llvm.sub %arg2, %arg1 overflow<nsw, nuw> : i64
    %4 = llvm.sub %2, %3 overflow<nuw> : i64
    %5 = llvm.shl %4, %0 overflow<nuw> : i64
    %6 = llvm.and %5, %1 : i64
    %7 = llvm.srem %0, %6 : i64
    %8 = llvm.icmp "sge" %4, %7 : i64
    %9 = llvm.trunc %8 : i1 to i64
    return %9 : i64
  }
}
