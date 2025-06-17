module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 861 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
