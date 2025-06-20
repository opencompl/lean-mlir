module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 58 : index} {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
