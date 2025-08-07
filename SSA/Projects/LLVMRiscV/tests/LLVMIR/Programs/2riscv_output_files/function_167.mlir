module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 166 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
