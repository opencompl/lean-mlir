module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 11 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
