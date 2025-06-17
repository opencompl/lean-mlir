module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 167 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.add %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
