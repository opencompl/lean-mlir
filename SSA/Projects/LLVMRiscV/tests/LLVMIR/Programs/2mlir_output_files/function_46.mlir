module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 45 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    return %1 : i1
  }
}
