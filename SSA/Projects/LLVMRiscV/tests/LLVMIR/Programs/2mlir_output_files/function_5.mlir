module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 4 : index} {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %1 : i64
  }
}
