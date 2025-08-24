module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 653 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
