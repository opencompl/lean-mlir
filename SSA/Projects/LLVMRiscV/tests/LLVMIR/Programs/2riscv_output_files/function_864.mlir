module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 863 : index} {
    %0 = llvm.sub %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
