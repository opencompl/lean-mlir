module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 194 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
