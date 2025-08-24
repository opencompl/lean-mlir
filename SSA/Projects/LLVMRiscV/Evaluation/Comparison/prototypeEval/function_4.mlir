module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 10 : index} {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
