module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 172 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
