module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 883 : index} {
    %0 = llvm.add %arg1, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
