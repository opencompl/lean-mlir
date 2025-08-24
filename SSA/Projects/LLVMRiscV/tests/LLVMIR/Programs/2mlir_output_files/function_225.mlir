module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 224 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    return %1 : i1
  }
}
