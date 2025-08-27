module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1) -> i1 {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %arg2 : i64
    %3 = llvm.sub %2, %2 overflow<nuw> : i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.add %4, %arg1 overflow<nuw> : i64
    %6 = llvm.and %4, %5 : i64
    %7 = llvm.zext %arg3 : i1 to i64
    %8 = llvm.sub %6, %7 overflow<nuw> : i64
    %9 = llvm.icmp "ult" %5, %8 : i64
    return %9 : i1
  }
}
