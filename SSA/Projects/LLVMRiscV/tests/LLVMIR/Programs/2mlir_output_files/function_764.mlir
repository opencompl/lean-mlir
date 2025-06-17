module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 763 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    return %1 : i1
  }
}
