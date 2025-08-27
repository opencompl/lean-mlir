module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.shl %0, %arg1 overflow<nuw> : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %arg0, %arg0 : i64
    %5 = llvm.udiv %1, %arg1 : i64
    %6 = llvm.lshr %5, %2 : i64
    %7 = llvm.mul %6, %arg2 overflow<nuw> : i64
    %8 = llvm.sdiv %4, %7 : i64
    %9 = llvm.icmp "ule" %3, %8 : i64
    return %9 : i1
  }
}
