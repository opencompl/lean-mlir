module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 613 : index} {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    return %1 : i1
  }
}
