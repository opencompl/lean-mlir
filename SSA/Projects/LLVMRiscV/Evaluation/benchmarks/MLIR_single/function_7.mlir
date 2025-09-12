module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.add %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg2 : i64
    %2 = llvm.select %arg1, %arg0, %1 : i1, i64
    %3 = llvm.xor %arg2, %arg2 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    %7 = llvm.mul %4, %0 overflow<nsw> : i64
    %8 = llvm.shl %6, %7 overflow<nsw> : i64
    %9 = llvm.icmp "slt" %8, %7 : i64
    return %9 : i1
  }
}
