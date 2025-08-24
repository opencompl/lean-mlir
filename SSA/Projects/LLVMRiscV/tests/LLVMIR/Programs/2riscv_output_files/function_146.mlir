module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 145 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
