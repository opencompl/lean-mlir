module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 773 : index} {
    %0 = llvm.mul %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
