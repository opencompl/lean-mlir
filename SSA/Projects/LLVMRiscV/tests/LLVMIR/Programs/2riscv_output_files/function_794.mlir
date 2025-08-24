module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 793 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
