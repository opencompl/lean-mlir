module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 252 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "ne" %0, %0 : i64
    return %1 : i1
  }
}
